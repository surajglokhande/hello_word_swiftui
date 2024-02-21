//
//  Item.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 21/02/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
