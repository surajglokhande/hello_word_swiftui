//
//  BookListView.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var addNewBook: Bool = false
//    @State private var path = [Book]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack(spacing: 10) {
                            Image(systemName: "books.vertical.fill")
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.title2)
                                Text(book.author)
                                    .font(.title3)
                                HStack {
                                    if let rating = book.rating {
                                        ForEach(0..<rating, id: \.self) { _ in
                                            Image(systemName: "star.fill")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        context.delete(books[index])
                    }
                }
            }
            .navigationTitle("iBook")
            .sheet(isPresented: $addNewBook, content: BookAddView.init)
//            .navigationDestination(for: Book.self, destination:BookAddView.init)
            .toolbar {
                Button {
//                    _ = BookAddView.init
                    addNewBook.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        
    }
    
    func addSample() {
        let book = Book(
            title: "Swift programming",
            author: "Suraj Lokhande",
            rating: 4,
            status: .onShelf
        )
        let book1 = Book(
            title: "Kotlin programming",
            author: "Suraj Lokhande",
            rating: 2,
            status: .onShelf
        )
        let book2 = Book(
            title: "java programming",
            author: "Suraj Lokhande",
            rating: 1,
            status: .onShelf
        )
        context.insert(book)
        context.insert(book1)
        context.insert(book2)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        
        let book = Book(
            title: "Swift programming",
            author: "Suraj Lokhande",
            rating: 3,
            status: .onShelf
        )
        
        container.mainContext.insert(book)
        
        return BookListView()
            .modelContainer(container)
    }catch {
        fatalError("view faied to load...")
    }
    
}
