//
//  RenderObservableBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 09/10/25.
//

import SwiftUI

@Observable
class TaskViewModelObservable {
    var tasks: [String] = []
    var count: Int = 5
    
    func addTask(_ task: String) {
        // When this property changes, any view observing this object will update
        tasks.append(task)
    }
}

struct TaskListViewObservable: View {
    @Bindable var viewModel: TaskViewModelObservable
    
    var body: some View {
        
        let _ = Self._printChanges()
        
        VStack {
            TextViewOneObservable()
            
            TextViewTwoObservable(count: $viewModel.count)
            
            List(viewModel.tasks, id: \.self) { task in
                Text(task)
            }
            
            ButtonViewObservable(viewModel: viewModel)
        }
    }
}

struct ButtonViewObservable: View {
    
    @State var viewModel: TaskViewModelObservable
    var body: some View {
        let _ = Self._printChanges()
        Button("Add Task") {
            viewModel.addTask("New Task \(viewModel.tasks.count + 1)")
            viewModel.count += 1
        }
        .foregroundStyle(.debug)
    }
}

struct TextViewOneObservable: View {
    
    var body: some View {
        let _ = Self._printChanges()
        Text("Count: 5")
            .foregroundStyle(.debug)
    }
}

struct TextViewTwoObservable: View {
    
    @Binding var count: Int
    
    var body: some View {
        let _ = Self._printChanges()
        Text("Count: \(count)")
            .foregroundStyle(.debug)
    }
}

struct RenderObservableBootcamp: View {
    @State var viewModel = TaskViewModelObservable()
    
    var body: some View {
        let _ = Self._printChanges()
        
        TaskListViewObservable(viewModel: viewModel)
    }
}

#Preview {
    RenderObservableBootcamp()
}
