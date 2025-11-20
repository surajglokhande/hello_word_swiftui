//
//  SwiftDataBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 11/08/25.
//

import SwiftUI
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}

struct DestinationList: View {
    
    @Query(sort: \Destination.name) var destination: [Destination]
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(destination) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                            Text(destination.date.formatted(date: .long, time: .shortened))
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteDestination)
            }
            .listStyle(.automatic)
            .navigationTitle(Text("iTour"))
            .navigationDestination(for: Destination.self, destination: EditDestination.init)
            .toolbar {
                Button {
                    addSamples()
                } label: {
                    Text("Add Samples")
                }
                Button("Add New iTour", systemImage: "plus") {
                    addDestination()
                }
                Menu("Menu", systemImage: "arrow.up.arrow.down") {
                    Button("sort up", systemImage: "arrow.up") {
                        
                    }.tag(SortDescriptor(\Destination.name))
                    Button("sort down", systemImage: "arrow.down") {
                        
                    }.tag(SortDescriptor(\Destination.name))
                }
            }
        }
    }
    
    func deleteDestination(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        modelContext.delete(destination[index])
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
    private func addSamples() {
        let newDelhi = Destination(name: "Nashik")
        let london = Destination(name: "Pune")
        let york = Destination(name: "Mumbai")
        modelContext.insert(newDelhi)
        modelContext.insert(london)
        modelContext.insert(york)
    }
}



#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try ModelContainer(for: Destination.self, configurations: config)

        let nashik = Destination(name: "Nashik")
        let pune = Destination(name: "Pune")
        let mumbai = Destination(name: "Mumbai")
        
        container.mainContext.insert(nashik)
        container.mainContext.insert(pune)
        container.mainContext.insert(mumbai)
        
        return DestinationList()
            .modelContainer(container)
    }catch {
        fatalError("")
    }
}
