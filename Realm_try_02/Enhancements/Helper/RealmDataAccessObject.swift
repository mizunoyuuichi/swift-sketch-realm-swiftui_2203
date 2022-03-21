// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation
import Realm
import RealmSwift

typealias RealmSortDescriptor = RealmSwift.SortDescriptor

protocol DataAccessUsecase {
    
    associatedtype RealmObject : RealmSwift.Object
    
    func all() -> [RealmObject]
    func find(_ key: AnyObject) -> RealmObject?
    // multiple conditions filter
    // - condition_A and condition_B or condition_C
    // - sorted and sorted
    func filter(_ predicates: [NSPredicate]?, sorts: [RealmSortDescriptor]?) -> [RealmObject]?
    func append(_ object: RealmObject)
    func append(_ objects: [RealmObject])
    func update(_ object: RealmObject, operation: (() -> ())?) -> Bool
    func remove(key: AnyObject)
    func remove(_ object: RealmObject)
    func removeAll()
    
    func first(_ predicates: [NSPredicate]?, sorts: [RealmSortDescriptor]?) -> RealmObject?
    func last(_ predicates: [NSPredicate]?, sorts: [RealmSortDescriptor]?) -> RealmObject?
}



class RealmDataAccessObject <T: RealmSwift.Object> {
    
    var realm: Realm
    
    init(){
        do {
            self.realm = try Realm()
        }
        catch let error {
            print("DAO<\(T.self)>.init - fail")
            print(error.localizedDescription)
            fatalError()
        }
    }
}



// MARK: - public
extension RealmDataAccessObject : DataAccessUsecase {
    
    typealias RealmSwiftObject = T
    
    func all() -> [T] {
        convertToArray(realm.objects(T.self))
    }
    
    func find(_ key: AnyObject) -> T? {
        realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    /// predicate: [NSPredicate(format: "property == %@", "value")]
    /// sorted:
    func filter(_ predicates: [NSPredicate]? = nil, sorts: [RealmSortDescriptor]? = nil) -> [T]? {
        var results = realm.objects(T.self)
        
        if let predicates = predicates {
            for (_,predicate) in predicates.enumerated() {
                results = results.filter(predicate)
            }
        }
        if let sorts = sorts {
            results = results.sorted(by: sorts)
        }
        
        return convertToArray(results)
    }
    
    func append(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        }
        catch let error {
            print("DAO<\(T.self)>.append - fail, ", error.localizedDescription)
        }
    }
    
    func append(_ objects: [T]) {
        do {
            try realm.write {
                for (_,object) in objects.enumerated() {
                    realm.add(object)
                }
            }
        }
        catch let error {
            print("DAO<\(T.self)>.append([T]) - fail, ", error.localizedDescription)
        }
    }
    
    /// Update
    /// - Parameters:
    ///   - object: RealmSwift.Object. (primaryKey used only!)
    ///   - operation: operation write here, if update write directly.
    /// - Returns: success or failure
    func update(_ object: T, operation: (() -> ())? = nil) -> Bool {
        do {
            try realm.write {
                operation?()
                realm.add(object, update: .all)
            }
            return true
        }
        catch let error {
            print("DAO<\(T.self)>.update - fail, ", error.localizedDescription)
            return false
        }
    }
    
    func remove(key: AnyObject) {
        if let target = find(key) {
            remove(target)
        }
        else {
            print("DAO<\(T.self)>.remove(key:) - not found, ")
        }
    }
    /// Can only belongs to managed.
    func remove(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        }
        catch let error {
            print("DAO<\(T.self)>.remove - fail, ", error.localizedDescription)
        }
    }
    
    func removeAll() {
        do {
            let kindOfObjects = all()
            try realm.write {
                realm.delete(kindOfObjects)
            }
        }
        catch let error {
            print("DAO<\(T.self)>.remove - fail, ", error.localizedDescription)
        }
    }
    
    
    func first(_ predicates: [NSPredicate]? = nil, sorts: [RealmSortDescriptor]? = nil) -> T? {
        filter(predicates, sorts: sorts)?.first
    }
    
    func last(_ predicates: [NSPredicate]? = nil, sorts: [RealmSortDescriptor]? = nil) -> T? {
        filter(predicates, sorts: sorts)?.last
    }
}



// MARK: - private
extension RealmDataAccessObject {

    private func convertToArray(_ result: Results<T>) -> [T] {
        var objects = [T]()
        let results = realm.objects(T.self)
        for (_,object) in results.enumerated() {
            objects.append(object)
        }
        return objects
    }
}
