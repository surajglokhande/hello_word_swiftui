//
//  ArrayProgramBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 11/12/25.
//

import SwiftUI

struct ArrayProgramBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let numbers = [1, 2, 3, 3, 4, 10, 11,11, 15, 20, 21, 22, 23]
                
                
                let grouped = numbers.reduce(into: [[Int]]()) { result, next in
                    // Check if the current number is consecutive with the last number in the last sequence
                    if var lastSequence = result.last, let last = lastSequence.last, next == last + 1 {
                        lastSequence.append(next)
                        result[result.endIndex - 1] = lastSequence
                    } else {
                        // If not consecutive, start a new sequence
                        result.append([next])
                    }
                }
                
                print(grouped)
                // Output: [[1, 2, 3, 4], [10, 11], [15], [20, 21, 22, 23]]

            }
    }
}

#Preview {
    ArrayProgramBootcamp()
}
