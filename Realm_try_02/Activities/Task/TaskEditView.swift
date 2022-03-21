// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct TaskEditView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var vm: TasksViewModel
    
    var task: Task
    
    @State private var title: String = ""
    @State private var enabledDueDate: Bool = false
    @State private var dueDate: Date = Date()
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 24) {
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Title").foregroundColor(Color.gray)
                TextField("Enter title..", text: $title)
                    .font(.largeTitle)
                Divider()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text("Due date")
                    .foregroundColor(Color.gray)
                Toggle(isOn: $enabledDueDate) {
                    Text("Enabled")
                }
                if enabledDueDate == true {
                    DatePicker("", selection: $dueDate, displayedComponents: .date)
                        .labelsHidden()
                        .foregroundColor(Color("text_reqular"))
                        .padding(.all, 0)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                        .offset(x: -8)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
                Divider()
            }
            
            Button(action: erase) {
                
                HStack {
                    Image(systemName: "trash.fill")
                    Text("Delete")
                }
                .foregroundColor(Color.red)
            }
            
            Spacer()
        }
        .navigationBarTitle("Edit Todo", displayMode: .inline)
        .padding(24)
        .onAppear{
            reflect()
        }
        .onDisappear {
            updated()
        }
    }
}



// MARK: - private
extension TaskEditView {
    
    private func reflect() {
        title = task.title
        enabledDueDate = task.dueDate != nil
        dueDate = task.dueDate ?? Date()
    }
    
    private func updated() {
        task.title = title
        task.dueDate = enabledDueDate ? dueDate : nil
        vm.updated(task)
    }
    
    private func erase() {
        vm.erase(editing: task)
        presentationMode.wrappedValue.dismiss()
    }
}
