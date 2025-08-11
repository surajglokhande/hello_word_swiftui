//
//  ContentView.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 29/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) var modelContext
	@Query var todos: [ToDo]
	@Query var authors: [Author]

	var body: some View {
		VStack {
			if authors.first != nil {
				@Bindable var author = authors[0]

				TextField("Autho", text: $author.name)
			}

			List {
				Section("ToDo") {
					ForEach(todos) { todo in
						Row(todo: todo)
					}

					Button("Add ToDo") {
						modelContext.insert(ToDo(text: "New", complete: false))
					}
				}
			}
		}
		.padding()
	}

	struct Row: View {
		@Environment(\.modelContext) var modelContext
		@Bindable var todo: ToDo

		var body: some View {
			HStack {
				Toggle("", isOn: $todo.complete)
				TextField("", text: $todo.text).textFieldStyle(.roundedBorder)
			}
		}
	}
}


