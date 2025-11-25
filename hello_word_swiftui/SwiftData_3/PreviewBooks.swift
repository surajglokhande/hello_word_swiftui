//
//  PreviewBooks.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 25/11/25.
//

import Foundation
import SwiftData
import SwiftUI

struct PreviewBooks {
    //
    let container: ModelContainer
    
    init(schema: any PersistentModel.Type...) {
        do {
            let schema = Schema(schema)
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: schema, configurations: config)
        }catch {
            fatalError("view faied to load...")
        }
    }
    
    @MainActor
    func addSample(examples: [any PersistentModel]) {
        Task {
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
