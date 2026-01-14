//
//  PhotonProgramOne.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 02/01/26.
//

import SwiftUI
import Observation
@preconcurrency import Combine

struct TodoList: Decodable, Hashable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

struct PhotonProgramOne: View {
    
    @Bindable var viewModel: TodoViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.todoList, id: \.id) { list in
                            NavigationLink(value: list) {
                                    Text(list.title)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(10)
                                        
                                
                            }
                        }
                    }
                    .cornerRadius(20)
                    .padding()
                    
                }
            }
        }
        .navigationDestination(for: TodoList.self, destination: { list in
            SecoundViewa(user: list)
        })
        .task {
            await viewModel.fetchList()
        }
    }
}

struct SecoundViewa: View {
    var user: TodoList
    
    var body: some View {
        Text("\(user.title)")
    }
}

@Observable
@MainActor
class TodoViewModel {
    var todoList: [TodoList] = []
    var network: NetworkManagerProtocol?

    init(list: [TodoList] = [], network: NetworkManager) {
        self.todoList = list
        self.network = network
    }
    
    func fetchList() async {
        do {
            if let data = try await network?.fetchtoDoAPI() {
                self.todoList = data
            }
        }catch {
            print("Fetching failed: \(error)")
        }
    }
}

protocol NetworkManagerProtocol {
    func fetchtoDoAPI() async throws -> [TodoList]
}

class NetworkManager: NetworkManagerProtocol {
    
    var todoList: [TodoList] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchtoDoAPI() async throws -> [TodoList] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let (data, response) = try await URLSession.shared.data(
            for: URLRequest(url:url)
        )
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        return try JSONDecoder().decode([TodoList].self, from: data)
    }
}

#Preview {
    let viewModel = TodoViewModel(network: NetworkManager())
    PhotonProgramOne(viewModel: viewModel)
}
