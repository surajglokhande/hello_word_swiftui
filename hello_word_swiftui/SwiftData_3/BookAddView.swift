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
    @State private var summary: String = ""
    @State private var rating: Int = 5
    
    var body: some View {
        Form {
            TextField("Book title", text: $title)
            TextField("Book Author", text: $author)
            TextField("Book Summery", text: $summary)

            HStack {
                HStack {
                    ForEach(0..<5, id: \.self) { index in
                        Button {
                            print(index)
                            //rating = index
                        } label: {
                            //rating > index ? Image(systemName: "star.fill") : Image(systemName: "star")
                        }
                    }
                }
                Spacer()
                Button("Create Book") {
                    let book = Book(
                        title: title,
                        author: author,
                        summary: summary,
                        rating: rating
                    )
                    context.insert(book)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    BookAddView()
}
