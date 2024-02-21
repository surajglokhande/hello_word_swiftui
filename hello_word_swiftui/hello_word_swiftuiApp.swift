//
//  hello_word_swiftuiApp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 21/02/24.
//

import SwiftUI
import SwiftData

@main
struct hello_word_swiftuiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
