// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import Foundation
import Combine
import RealmSwift

protocol TaskUsecase {
    func dragStared(_ task: Task)
    func dropFinished(_ task: Task)
    func entered()
    func erase(editing task: Task)
}



final class TasksViewModel: ObservableObject {
    
    @Published var formText: String = ""
    @Published var tasks: [Task] = []
    @Published var dragged: Task?
    @Published var editingTask: Task? = Task(title: "")
    
    var sampleTasks = [ Task(title: "a"), Task(title: "b"), Task(title: "c"), Task(title: "d") ]
    
    private (set) var publisher = ObservableObjectPublisher()
    private let dao = RealmDataAccessObject<Task>()

    init() {
        //tasks = sampleTasks  // check
        tasks = dao.all()
    }
}



// MARK: - public
extension TasksViewModel: TaskUsecase {
    
    func dragStared(_ task: Task) {
        dragged = task
    }
    
    func dropFinished(_ task: Task) {
        guard let dragged = dragged else { return }
        dropped(from: dragged, to: task)
    }
    
    func entered() {
        let newTask = Task(title: formText)
        dao.append(newTask)
        tasks.append(newTask)
        formText = ""
        publisher.send()
    }
    
    func updated(_ updated: Task) {
        guard let position = tasks.firstIndex(where: {$0.id == updated.id}) else { return }
              let target = tasks[position]
        if dao.update(target, operation: {
            target.merge(updated)
        }) {
            tasks[position] = target
            publisher.send()
        }
    }
    
    func erase(editing task: Task) {
        tasks = tasks.filter({$0.id != task.id})
        dao.remove(key: task.id)
        publisher.send()
    }
}



// MARK: - private
extension TasksViewModel {
    
    private func dropped(from dragged: Task, to dropped: Task) {
        guard let from = tasks.firstIndex(where: {$0.id == dragged.id}),
              let to   = tasks.firstIndex(where: {$0.id == dropped.id}) else { return }
        tasks.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
        self.dragged = nil
        publisher.send()
    }
}
