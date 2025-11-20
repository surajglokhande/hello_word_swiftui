//
//  EditDestination.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 20/11/25.
//

import SwiftUI

struct EditDestination: View {
    
    @Bindable var destination: Destination
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 30) {
                
                TextField("Name", text: $destination.name)
                TextField("Details", text: $destination.details, axis: .vertical)
                DatePicker("Date", selection: $destination.date)
                
                Section("Priority") {
                    Picker("Priority", selection: $destination.priority) {
                        Text("High").tag(1)
                        Text("Medium").tag(2)
                        Text("Low").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
                .listSectionSeparator(.visible)
            }
        }
        .listSectionSeparator(.visible)
        .listStyle(.automatic)
    }
}

#Preview {
    EditDestination(destination: Destination(name: "Nashik",
                                             details: "best weather city",
                                             date: .now,
                                             priority: 2)
    )
}
