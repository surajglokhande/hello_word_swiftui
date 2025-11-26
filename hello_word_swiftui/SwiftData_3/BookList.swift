//
//  BookList.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 25/11/25.
//

import SwiftUI
import SwiftData
import Foundation

struct BookList: View {
    
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    
    init(sortOrder: SortOrder, filter: String) {
        let sortDescriptor: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.author)]
        }
        let filterPredicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filter) ||
            book.author.localizedStandardContains(filter) ||
            filter.isEmpty
        }
        _books = Query(filter: filterPredicate, sort: sortDescriptor)
    }
    
    var body: some View {
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
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = PreviewBooks(schema: Book.self)
    let data = Book.sampleBooks
    preview.addSample(examples: data)
    return NavigationStack {
        BookList(sortOrder: .status, filter: "")
    }
    .modelContainer(preview.container)
}
