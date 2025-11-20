//
//  DataModel.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 29/08/24.
//

import Foundation
import UniformTypeIdentifiers
import SwiftData

@Model
class Author {
	var name: String

	init(name: String) {
		self.name = name
	}
}

@Model
class ToDo: Identifiable {
	var id: UUID
	var text: String
	var complete: Bool

	init(id: UUID = UUID(), text: String, complete: Bool) {
		self.id = id
		self.text = text
		self.complete = complete
	}
}


extension UTType {
	static var todos: UTType {
		UTType(exportedAs: "com.company.greatAppdocument")
	}
}




