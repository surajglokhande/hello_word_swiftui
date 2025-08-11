//
//  StateObjectbootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 15/02/25.
//

import SwiftUI

@Observable
class User {
	var username = "suraj96tm" // if not write @Publish username will not changed on click me!
}
struct StateObjectbootcamp: View {
	@State var user = User()

	var body: some View {
		Text("Username: \(user.username)")
		Button {
			user.username = "shweta96tm"
		} label: {
			Text("Click me!")
		}
	}
}

#Preview {
	StateObjectbootcamp()
}
