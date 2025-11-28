//
//  BookAddView.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import SwiftUI

struct BookAddView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
//    @Bindable var book: Book
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var synopsis: String = ""
    @State private var rating: Int = 0
    
    var body: some View {
        Form {
            TextField("Book title", text: $title)
            TextField("Book Author", text: $author)
            HStack {
                Spacer()
                Button("Create Book") {
                    let book = Book(
                        title: title,
                        author: author,
                        synopsis: synopsis,
                        rating: rating
                    )
                    context.insert(book)
                    dismiss()
                }
                .padding(5)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    BookAddView()
}
