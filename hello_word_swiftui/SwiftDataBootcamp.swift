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

struct SwiftDataBootcamp: View {
    
    @Query var destination: [Destination]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(destination) { destination in
                    VStack{
                        NavigationLink(value: destination) {
                            Text("\(destination.name)")
                        }
                    }
                }
                .onDelete(perform: deleteDestination)
            }
            .listStyle(.plain)
            .navigationTitle(Text("Swift Data"))
            .navigationDestination(for: Destination.self, destination: EditDestination.init)
            .toolbar {
                Button {
                    addSamples()
                } label: {
                    Text("Add Samples")
                }

            }
        }
    }
    
    func deleteDestination(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        modelContext.delete(destination[index])
    }
    
    private func addSamples() {
        let newDelhi = Destination(name: "cqcqq")
        let london = Destination(name: "london")
        let york = Destination(name: "new york")
        modelContext.insert(newDelhi)
        modelContext.insert(london)
        modelContext.insert(york)
    }
}

struct EditDestination: View {
    
    @Bindable var destination: Destination
    
    var body: some View {
//        Color(.yellow)
        VStack {
            TextField("Name", text: $destination.name)
//                .padding(.horizontal)
                .background(.gray)
                .padding(10)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                
//                .cornerRadius(10)
                
                
                
//            Spacer()
        }/*.background(.gray)*/
    }
}

//#Preview {
//    SwiftDataBootcamp()
//}
#Preview {
    EditDestination(destination: Destination(name: "dwc"))
}
