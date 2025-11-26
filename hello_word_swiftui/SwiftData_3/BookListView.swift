//
//  BookListView.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {

    @State private var addNewBook: Bool = false
    @State private var sortOrder: SortOrder = .status
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            Picker("Sort", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { item in
                    Text("Sort by: \(item)").tag(item)
                }
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filter: searchText)
                .searchable(text: $searchText, prompt: "Filter on title or author")
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
