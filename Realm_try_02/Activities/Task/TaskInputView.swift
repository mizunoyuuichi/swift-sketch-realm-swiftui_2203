// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct TaskInputView: View {
    
    @ObservedObject var vm: TasksViewModel
    
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            TextField("Enter New Todo..", text: $vm.formText, onCommit:  {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                submit()
            })

            Button(action: submit) {
                Image(systemName: "plus")
            }
        }
    }
}



// MARK: - private
extension TaskInputView {
    
    private func submit() {
        vm.entered()
    }
}
