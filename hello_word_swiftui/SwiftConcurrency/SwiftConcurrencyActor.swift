//
//  SwiftConcurrencyActor.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 03/11/25.
//

import Foundation
import SwiftUI

//old way
/*
class MyDataManager {
    static let shared = MyDataManager()
    
    private init() {}
    
    var data: [String] = []
    private var lock = DispatchQueue(label: "com.dispatchqueue.lock")
    
    //problem
//    func getRandomData() -> String? {
//        self.data.append(UUID().uuidString)
//        print(Thread.current)
//        return data.randomElement()
//    }
    //solution
    func getRandomData(handler: @escaping (String?)->Void) {
        lock.async { [weak self] in
            self?.data.append(UUID().uuidString)
            print(Thread.current)
            handler(self?.data.randomElement())
        }
    }
}
 */

actor MyDataManager {
    
    static let shared = MyDataManager()
    private init() {}
    var data: [String] = []

    func getRandomData() async -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    func getRandomStringOne() -> String {
        return "new data"
    }
    
    nonisolated func getRandomStringTwo() -> String {
        return "new data"
    }
}

struct SwiftConcurrencyActor: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill", content: {
                HomeView()
            })
            Tab("Profile", systemImage: "magnifyingglass", content: {
                ProfileView()
            })
        }
    }
}

struct HomeView: View {
    let manager = MyDataManager.shared
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(1)
            Text("\(text)")
        }
        .onAppear {
            //not required await and Task block because of nonisolated
            let two = manager.getRandomStringTwo()
            
            //required await and Task block to execute
            Task {
                let thre = await manager.getRandomStringOne()
            }
        }
        .onReceive(timer) { _ in
//            DispatchQueue.global(qos: .background).async {
//            print("inside home")
                //problem
//                if let data = manager.getRandomData() {
//                    DispatchQueue.main.async {
//                        text = data
//                    }
//                }
                //solution old way
//                manager.getRandomData { data in
//                    DispatchQueue.main.async {
//                        if let _data = data {
//                            text = _data
//                        }
//                    }
//                }
//            }
            //solution new way
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        text = data
                    }
                }
            }
        }
    }
}

struct ProfileView: View {
    
    let manager = MyDataManager.shared
    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.red.opacity(1)
            Text("\(text)")
        }
        .onReceive(timer) { _ in
//            DispatchQueue.global(qos: .default).async {
//            print("inside profile")
                //problem
//                if let data = manager.getRandomData() {
//                    DispatchQueue.main.async {
//                        text = data
//                    }
//                }
                //solution old way
//                manager.getRandomData { data in
//                    DispatchQueue.main.async {
//                        if let _data = data {
//                            text = _data
//                        }
//                    }
//                }
//            }
            //solution new way
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run {
                        text = data
                    }
                }
            }
        }
    }
}

#Preview {
    //SwiftConcurrencyActor()
}
//: [Next](@next)

