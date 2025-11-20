//
//  iTourBootCamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 20/11/25.
//

import SwiftUI

struct iTourSwiftDataBootCamp: View {
    
    
    var body: some View {
        DestinationList()
            .modelContainer(for: [Destination.self])
    }
}

#Preview {
    iTourSwiftDataBootCamp()
}
