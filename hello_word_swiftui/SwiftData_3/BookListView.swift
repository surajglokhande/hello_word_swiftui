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
    
    var body: some View {
        NavigationStack {
            Group {
                if books.isEmpty {
                    ContentUnavailableView(
                        "Data Not Found!",
                        systemImage: "exclamationmark.triangle.fill",
                        description: Text("Data is available at this movement")
                    )
                }else {
                    List {
                        ForEach(books) { book in
                            NavigationLink(value: book) {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.title3)
                                        Text(book.author)
                                            .font(.subheadline)
                                        HStack {
                                            if let rating = book.rating {
                                                ForEach(1..<rating, id: \.self) { _ in
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
                }
            }
            .navigationTitle("iBook")
            .sheet(isPresented: $addNewBook, content: {
                BookAddView()
                    .presentationDetents([.medium])
            })
            .navigationDestination(for: Book.self, destination: { book in
                BooKEditView(book: book)
            })
            .toolbar {
                Button {
                    addNewBook.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        
    }
}

#Preview {
    let preview = PreviewBooks(schema: Book.self)
    let data = Book.sampleBooks
    preview.addSample(examples: data)
    return BookListView()
        .modelContainer(preview.container)
}
