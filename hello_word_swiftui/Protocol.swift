//
//  Protocol.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 27/07/24.
//

import Foundation
import SwiftUI


//protocol ModifierProtocol: ViewModifier {
//
//}
struct PaddingModifier: ViewModifier {
	let value: CGFloat
	func body(content: Content) -> some View {
		content.padding(value)
	}
}

struct CornerRadiusModifier: ViewModifier {
	let radius: CGFloat
	func body(content: Content) -> some View {
		content.cornerRadius(radius)
	}
}

//extension View {
//	func modify(delegate: some ViewModifier) -> some View {
//		modifier(delegate.body(content: self as! _ViewModifier_Content<some ViewModifier>))
//	}
//}

struct TitleStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(.bottom, 20)

	}
}
extension View {
	func modifyTitleStyle() -> some View {
		modifier(TitleStyle())
	}
}
