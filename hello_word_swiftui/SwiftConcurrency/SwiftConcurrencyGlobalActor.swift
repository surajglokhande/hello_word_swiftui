//
//  SwiftConcurrencyGlobalActor.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 04/11/25.
//
/*:
 @globalActor solves the problem of creating and enforcing a single, shared execution context for specific parts of an application, such as UI updates or file system access. This ensures that all code marked with the global actor consistently runs on the same thread or queue, preventing data races and promoting predictable, thread-safe behavior across different parts of the app, which can be difficult to manage with regular actors alone. It allows developers to define a custom global execution context, similar to the built-in @MainActor, for specific domains like image processing or data management.
 
 - Problems solved by @globalActor
 - **Lack of a shared execution context:** Regular actors isolate data per instance, but don't provide a single, shared context for non-actor functions. @globalActor addresses this by creating a single, shared execution context that all marked functions and classes will use, similar to a singleton.
 - **Inconsistent execution:** Without a global actor, you would need to manually manage and track which thread or queue a specific task should run on, which can lead to errors. @MainActor for UI and custom global actors ensure consistency for specific domains like image loading or data storage.
 - **Difficulty managing shared resources:** When an application has a shared resource, like a data manager, that needs to be accessed safely from many places, a @globalActor provides a simple way to guarantee that access is synchronized and thread-safe.
 - **Need for thread-safe operations on non-actor types:** You can use @globalActor to isolate methods and properties of a regular class or struct, ensuring that mutations to its state occur within the actor's isolation boundary, which the Swift compiler will enforce.
 */
import SwiftUI

@globalActor
actor MyNewDataManager {
    
    static let shared = MyNewDataManager()
    
    func getMyNewData() -> [String] {
        return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    }
}

@Observable
class GlobalActorViewModel {
    
    var data: [String] = []
    var manager = MyNewDataManager.shared
    
    @MyNewDataManager func getData() {
        
        //HEAVY COMPLEX TASK
        Task {
            let _data = await manager.getMyNewData()
            self.data = _data
        }
    }
}

struct SwiftConcurrencyGlobalActor: View {
    
    @State private var viewModel = GlobalActorViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.data, id: \.self) {
                    Text($0)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

#Preview {
    SwiftConcurrencyGlobalActor()
}
