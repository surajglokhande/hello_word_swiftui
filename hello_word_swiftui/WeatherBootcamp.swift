//
//  WeatherBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 26/07/24.
//

import SwiftUI

struct WeatherBootcamp: View {
	
    var body: some View {
		ZStack(content: {
			LinearGradient(colors: [.blue, .blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
				.ignoresSafeArea()
			VStack(spacing: 55) {
				Text("Pune, MH")
					//.padding(.bottom, 20)
					.modifier(PaddingModifier(value: 10))
					.modifier(TitleStyle()) //OR .modifyTitleStyle()
					.font(.system(size: 25))
					.fontWeight(.semibold)
					.foregroundStyle(.white)
				Image(systemName: "cloud.sun.fill")
					.aspectRatio(contentMode: .fill)
					.symbolRenderingMode(.palette)
					.foregroundStyle(.white, .yellow)
					.font(.system(size: 140.0))
				Text("76")
					.font(.system(size: 60))
					.fontWeight(.semibold)
					.foregroundStyle(.white)
				//CommonView //OR 
				hello_word_swiftui.CommonView()
				Button(action: {}, label: {
					Text("Change Time of Day")
						.padding(.horizontal, 30)
						.font(.system(size: 20).bold())
						.foregroundStyle(.blue)
				})
				.frame(height: 45)
				.background(.white)
				.clipShape(.capsule)
			}.padding()
		})
    }
}

extension WeatherBootcamp {
	var CommonView: some View {
		HStack {
			ForEach(0..<5) { i in
				DailyWeather()
			}
		}
	}
}

struct DailyWeather: View {
	var body: some View {
		VStack {
			Text("SUN")
				.padding()
				.font(.system(size: 10))
				.fontWeight(.semibold)
				.foregroundStyle(.white)
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
		}
	}
}

#Preview {
    WeatherBootcamp()
}
