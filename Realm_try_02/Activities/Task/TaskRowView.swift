// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct TaskRowView: View {

    @ObservedObject var vm: TasksViewModel
    @State var isActive = false
    
    let row: Task
    
    
    var body: some View {
        
        VStack {

            HStack(spacing: 8) {
                
                Button(action: { toggle() }) {
                    Image(systemName: row.completed ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(row.completed ? Color.green : Color.gray)
                }
                NavigationLink(destination: TaskEditView(vm: vm, task: row), isActive: $isActive) {
                    Text(row.title)
                        .frame(minWidth: 64, alignment: .leading)
                        .foregroundColor(Color("text_reqular"))
                }
                .onTap{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isActive = true  // note: enable delayed execution. for API
                    }
                }
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            Divider().padding(.leading, 0).frame(height: 1)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
        .contentShape(Rectangle())
    }
}



// MARK: - private
extension TaskRowView {
    
    private func toggle() {
        row.completed = !row.completed
        vm.updated(row)
    }
}
