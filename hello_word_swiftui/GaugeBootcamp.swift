//
//  GaugeBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 02/02/25.
//

import SwiftUI

struct GaugeBootcamp: View {
	var body: some View {
		Gauge(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, in: /*@START_MENU_TOKEN@*/0...1/*@END_MENU_TOKEN@*/) {
			Text("GaugeBootcamp")
		}
	}
}

#Preview {
	GaugeBootcamp()
}
