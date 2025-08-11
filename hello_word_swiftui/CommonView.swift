//
//  CommonView.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 27/07/24.
//

import SwiftUI

struct CommonView: View {
	var day = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    var body: some View {
		HStack {
			ForEach(0..<5) { i in
				DayWeather(today: day[i], content: {
					Image(systemName: "cloud.sun.fill")
						.aspectRatio(contentMode: .fill)
						.symbolRenderingMode(.palette)
						.foregroundStyle(.white, .yellow)
						.font(.system(size: 30))
						.padding(5)
					Text("76")
						.font(.system(size: 30))
						.fontWeight(.semibold)
						.foregroundStyle(.white)
				})
			}
		}
    }
}

struct DayWeather<Content: View>: View {

	let today: String
	let content: Content

	init(today: String, @ViewBuilder content: @escaping () -> Content) {
		self.today = today
		self.content = content()
	}
	var body: some View {
		VStack {
			Text(today)
				.padding()
				.font(.system(size: 10))
				.fontWeight(.semibold)
				.foregroundStyle(.white)
			content
		}
	}
}

//#Preview {
//	CommonView()
//}
