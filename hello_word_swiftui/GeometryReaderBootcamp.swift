//
//  GeometryReaderBootcamop.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 31/05/25.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        GeometryReader { geometryProxy in
            Rectangle()
                .fill(Color.yellow)
                .background(.gray)
            VStack{
                Text("cordinate: \(geometryProxy.frame(in: .global).origin.x), \(geometryProxy.frame(in: .global).origin.y)")
                Text("cordinate: \(geometryProxy.frame(in: .local).origin.x), \(geometryProxy.frame(in: .local).origin.y)")
            }
            .foregroundStyle(.blue)
        }
        .background(Color.red)
    }
}

#Preview {
    GeometryReaderBootcamp()
}
