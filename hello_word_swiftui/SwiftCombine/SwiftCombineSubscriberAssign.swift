//
//  SwiftCombineSubscriberAssign.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 06/11/25.
//

import SwiftUI
import Combine

struct SwiftCombineSubscriberAssign: View {
    var body: some View {
        TimerView()
    }
}

#Preview {
    SwiftCombineSubscriberAssign()
}

class MyModelOne: ObservableObject {
    @Published var lastUpdated: Date = Date()
    // No need for a cancellables set with assign(to:)

    init() {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .assign(to: &$lastUpdated) // Assign directly to the @Published property
//            .assign(to: \.lastUpdated, on: self)
    }
}

struct TimerView: View {
    @StateObject var model = MyModelTwo()

    var body: some View {
        Text("Last updated: \(model.lastUpdated, formatter: DateFormatter.shortTime)")
    }
}

extension DateFormatter {
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
}


class MyModelTwo: ObservableObject {
    @Published var lastUpdated: Date = Date()
    
    // ⚠️ 1. CRITICAL: A property is needed to store the AnyCancellable.
    // This keeps the subscription alive.
    private var timerCancellable: AnyCancellable?

    init() {
        let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
        
        // 2. Use the KeyPath syntax: .assign(to: \.property, on: object)
        // 3. Store the result in the cancellable property defined above.
        self.timerCancellable = timerPublisher
            .assign(to: \.lastUpdated, on: self)
    }
    
    // ⚠️ Optional, but recommended: Cancel the subscription when the object is deallocated
    deinit {
        timerCancellable?.cancel()
    }
}



