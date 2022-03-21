// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var vm: TasksViewModel

    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: GridItem.singleFit, spacing: 16) {
                
                ForEach(vm.tasks) { task in
                    
                    // note: don't use navigationLink in ForEach
                    // note: don't update Realm Managed Object in ui
                    TaskRowView(vm: vm, row: task.clone()) // note: should have index? .. no
                        .onDrag {
                            vm.dragStared(task)
                            return NSItemProvider(object: task)
                        }
                        .onDrop(kDragTaskKey) {
                            vm.dropFinished(task)
                        }
                }
            }
        }
        .onAppear(perform: {
            UIScrollView.appearance().bounces = false
        })
    }
}



// MARK: - private
extension TaskListView {}
