//
//  SwiftConcurrencyRefreshable.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 05/11/25.
//

import SwiftUI

actor MyDataProvider {
    
    func getData() async throws -> [String] {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return ["One","Two","Three"].shuffled()
    }
}

@Observable
@MainActor
final class RefreshableViewModel {
     var items: [String] = []
    var provider = MyDataProvider()
    
    func getDataFromProvider() async {
        do {
            items = try await provider.getData()
        }catch {
            print(error)
        }
        
    }
}

struct SwiftConcurrencyRefreshable: View {
    
    @State private var viewModel = RefreshableViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.items, id: \.self) {
                    Text($0)
                }
            }
        }
        .refreshable {
            await self.viewModel.getDataFromProvider()
        }
        .task {
            await self.viewModel.getDataFromProvider()
        }
    }
}

#Preview {
    SwiftConcurrencyRefreshable()
}
