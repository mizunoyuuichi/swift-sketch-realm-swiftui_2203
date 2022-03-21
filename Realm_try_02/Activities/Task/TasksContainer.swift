// Copyright © 2022 Yuuichi Mizuno. All rights reserved.

import SwiftUI

struct TasksContainer: View {
    
    var viewModel = TasksViewModel()
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TaskInputView(vm: viewModel)
                
                Spacer().frame(height: 16)
                
                TaskListView(vm: viewModel)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.automatic)
            .animation(.easeOut)
        }
        .navigationViewStyle(.stack)
    }
}

struct TasksContainer_Previews: PreviewProvider {
    static var previews: some View {
        TasksContainer()
    }
}
