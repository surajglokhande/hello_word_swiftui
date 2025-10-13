//
//  Extension.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 09/10/25.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var debug: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
