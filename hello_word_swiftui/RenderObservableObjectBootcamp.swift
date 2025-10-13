//
//  RenderObservableObject.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 09/10/25.
//

import SwiftUI

// 1. Create a model that conforms to ObservableObject
class TaskViewModelObservableObject: ObservableObject {
    // @Published tells SwiftUI which properties should trigger updates
    @Published var tasks: [String] = []
    @Published var count: Int = 5
    
    func addTask(_ task: String) {
        // When this property changes, any view observing this object will update
        tasks.append(task)
    }
}

// 2. Create a view that uses the model with @ObservedObject
struct TaskListViewObservableObject: View {
    // This view will update whenever published properties in viewModel change
    @ObservedObject var viewModel: TaskViewModelObservableObject
    
    var body: some View {
        
        let _ = Self._printChanges()
        
        VStack {
            TextViewOneObservableObject()
            
            //binding resolved re-render issue by ObservedObject
            TextViewTwoObservableObject(count: $viewModel.count)
            List(viewModel.tasks, id: \.self) { task in
                Text(task)
            }
            
            ButtonViewObservableObject()
                .environmentObject(viewModel)
            //            Button("Add Task") {
            //                viewModel.addTask("New Task \(viewModel.tasks.count + 1)")
            //                viewModel.count += 1
            //            }
            //            .foregroundStyle(.debug)
        }
    }
}
struct ButtonViewObservableObject: View {
    @EnvironmentObject var viewModel: TaskViewModelObservableObject
    var body: some View {
        let _ = Self._printChanges()
        Button("Add Task") {
            viewModel.addTask("New Task \(viewModel.tasks.count + 1)")
            viewModel.count += 1
        }
        .foregroundStyle(.debug)
    }
}

struct TextViewOneObservableObject: View {
    
    var body: some View {
        let _ = Self._printChanges()
        Text("Count: 5")
            .foregroundStyle(.debug)
    }
}

struct TextViewTwoObservableObject: View {
    
    @Binding var count: Int
    
    var body: some View {
        let _ = Self._printChanges()
        Text("Count: \(count)")
            .foregroundStyle(.debug)
    }
}

// 3. Create a parent view that passes the viewModel
struct RenderObservableObjectBootcamp: View {
    // The parent view creates and owns the viewModel
    @StateObject var viewModel = TaskViewModelObservableObject()
    
    var body: some View {
        // Pass the viewModel to child views
        let _ = Self._printChanges()
        
        TaskListViewObservableObject(viewModel: viewModel)
    }
}

//struct StaticButton: View {
//    let action: () -> Void
//    var body: some View {
//        let _ = Self._printChanges()
//        Button("Tap Me", action: action)
//            .foregroundStyle(.debug)
//    }
//}
//
//struct ContentViewTwo: View {
//    @State private var count = 0
//    var body: some View {
//        let _ = Self._printChanges()
//        VStack {
//            StaticButton {
//                count += 1
//            }
//            Text("Count: \(count)")
//                .foregroundStyle(.debug)
//        }
//    }
//}

#Preview {
    RenderObservableObjectBootcamp()
}
