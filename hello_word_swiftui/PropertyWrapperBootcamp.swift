//
//  PropertyWrapperBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 30/07/24.
//

import SwiftUI

struct PropertyWrapperBootcamp: View {
    var body: some View {
		BindingContentView()
		//AppStorageContentView()
    }
}

struct AppStorageContentView: View {
	@AppStorage("username") var username : String?
		//@AppStorage("username", store: UserDefaults(suiteName: "com.suraj.swituidemos")) var username : String?
	@State var flag: Bool = true

	var body: some View {
		VStack(content: {
			Text("Hello, \(username ?? "value not set yet!")")
			Button(action: {
				username = flag ? "shweta96tm" : "suraj96tm"
				debugPrint("before:\(flag)")
				flag.toggle()
				debugPrint("after:\(flag)")
			}, label: {
				Text("Click me!")
			})
			if let text = username {
				Text("changed userdefault value: \(text)")
			}
			/*
			 internally used userdefault
			 */
			if let text = UserDefaults.standard.value(forKey: "username") as? String {
				Text("old userdefault value: \(text)")
			}
		})
	}
}

struct BindingContentView: View {

	@State private var showingAddUser = false

	var body: some View {
		VStack {
			Text("Demo of binding")
			Button(action: {
				debugPrint("before: \(showingAddUser)")
				showingAddUser.toggle()
				debugPrint("after: \(showingAddUser)")
			}, label: {
				Text("Click me!")
			}).sheet(isPresented: $showingAddUser) {
				AddView(isPresented: $showingAddUser)
			}
		}

	}
}
extension BindingContentView {
	struct AddView: View {
		@Binding var isPresented: Bool

		var body: some View {
			Button("Dismiss") {
				debugPrint("inside before: \(isPresented)")
				isPresented.toggle()
				debugPrint("inside after: \(isPresented)")
			}
		}
	}
}



#Preview {
    PropertyWrapperBootcamp()
}
