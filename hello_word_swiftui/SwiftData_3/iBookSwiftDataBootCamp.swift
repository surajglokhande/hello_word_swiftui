//
//  iBookSwiftDataBootCamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import SwiftUI
import SwiftData

struct iBookSwiftDataBootCamp: View {
    var body: some View {
        BookListView()
            .modelContainer(for: [Book.self])
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

#Preview {
    iBookSwiftDataBootCamp()
}
