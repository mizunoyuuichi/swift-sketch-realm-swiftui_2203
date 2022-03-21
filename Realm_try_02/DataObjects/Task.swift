// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation
import ObjectMapper
import RealmSwift

let kDragTaskKey = "org.atoms.drag.task"

class Task: Object, Identifiable, Codable, Mappable, NSCopying, NSItemProviderReading, NSItemProviderWriting {
     
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var title            : String = ""
    @Persisted var completed        : Bool   = false
    @Persisted var completedAt      : Date?  = nil
    @Persisted var dueDate          : Date?  = nil
    @Persisted var dailySortNumber  : Int?   = nil
    
    override init() {}
    required init?(map: ObjectiveMap) {}
    init(title: String) {
        self.title = title
    }

    func mapping(map: ObjectiveMap) {
        id                          <- map["id"]
        title                       <- map["title"]
        completed                   <- map["completed"]
        completedAt                 <- map["completedAt"]
        dueDate                     <- map["dueDate"]
        dailySortNumber             <- map["dailySortNumber"]
    }
    /// note : if not display only, use copy. ( realmObject throw error, when already saved one. )
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Task()
            copy.id                 = id
            copy.title              = title
            copy.completed          = completed
            copy.completedAt        = completedAt
            copy.dueDate            = dueDate
            copy.dailySortNumber    = dailySortNumber
        return copy as Any
    }
    
    func clone() -> Task {
        copy() as! Task
    }
    /// note: use only in DAO update blocks.
    func merge(_ updated: Task) {
        guard id == updated.id else { return }
        title              = updated.title
        completed          = updated.completed
        completedAt        = updated.completedAt
        dueDate            = updated.dueDate
        dailySortNumber    = updated.dailySortNumber
    }
}



// MARK: NSItemProviderReading
// MARK: NSItemProviderWriting
extension Task {
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        [kDragTaskKey]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
    
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        [kDragTaskKey]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        do {
            let data = try JSONEncoder().encode(self)
            completionHandler(data, nil)
        }
        catch {
            completionHandler(nil, error)
        }
        return nil
    }
}
