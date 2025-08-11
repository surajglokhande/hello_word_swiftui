//
//  NavigationViewBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 09/07/25.
//

import SwiftUI

struct UserTwo: Hashable {
    var name: String
}

struct NavigationViewBootcamp: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink("Go to next screen", value: UserTwo(name: "Suraj"))
//                NavigationLink {
//                    SecoundView(user: UserTwo(name: "Dhiraj"))
//                } label: {
//                    Text("Go to next View")
//                }
            }
        }
        .navigationDestination(for: UserTwo.self) { user in
            SecoundView(user: user)
        }
    }
}

struct NavigationStackBootcamp: View {
    var body: some View {
        NavigationStack() {
            NavigationLink("Go to Next Screen", value: UserTwo(name: "Dhiraj"))
            NavigationLink {
                SecoundView(user: UserTwo(name: "Dhiraj"))
            } label: {
                Text("Go to next View")
            }

        }
        .navigationDestination(for: UserTwo.self) { user in
            SecoundView(user: user)
        }
    }
}

struct SecoundView: View {
    var user: UserTwo
    
    var body: some View {
        Text("\(user.name)")
    }
}

#Preview {
    NavigationStackBootcamp()
}
