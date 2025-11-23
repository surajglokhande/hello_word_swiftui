//
//  Destination.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 22/11/25.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
