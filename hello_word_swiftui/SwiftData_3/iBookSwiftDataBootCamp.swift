//
//  iBookSwiftDataBootCamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import SwiftUI
import SwiftData

struct iBookSwiftDataBootCamp: View {
    let container: ModelContainer
    var body: some View {
        BookListView()
            .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        } catch {
//            fatalError("Could not configure the container")
//        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        print(URL.documentsDirectory.path())
    }}

#Preview {
    iBookSwiftDataBootCamp()
}
