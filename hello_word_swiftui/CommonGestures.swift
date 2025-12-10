//
//  CommonGestures.swift
//  
//
//  Created by Suraj Lokhande2 on 08/12/25.
//
import SwiftUI

struct PanToMove: ViewModifier {
    @State var offsetAmount: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .offset(offsetAmount)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offsetAmount = value.translation
                    }
            )
    }
}

struct PinchToZoom: ViewModifier {
    @State var currentScaleAmount = 0.0
    @State var finalScaleAmount = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(finalScaleAmount + currentScaleAmount)
            .gesture(
                MagnifyGesture()
                    .onChanged { value in
                        currentScaleAmount = value.magnification - 1
                    }
                    .onEnded { value in
                        if abs(currentScaleAmount) < 0.2 {
                            currentScaleAmount = 0.0
                            finalScaleAmount = 1.0
                        }
                        finalScaleAmount += currentScaleAmount
                        currentScaleAmount = 0
                    }
            )
    }
}

struct SwipeToDismiss: ViewModifier {
    @Binding var isPresented: Bool
    @State var verticalDragAmount = 0.0
    @State var opacityAmount = 1.0
    
    func body(content: Content) -> some View {
        content
            .offset(y: verticalDragAmount)
            .opacity(opacityAmount)
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        withAnimation {
                            verticalDragAmount = drag.translation.height
                            if drag.translation.height < 100 {
                                // make it more transparent the farther down it goes
                                opacityAmount = (100 - verticalDragAmount) / 100
                            } else {
                                opacityAmount = 0
                            }
                        }
                    }
                    .onEnded { drag in
                        withAnimation {
                            if drag.translation.height > 100 {
                                isPresented = false
                                opacityAmount = 0
                            } else {
                                verticalDragAmount = 0
                                opacityAmount = 1
                            }
                        }
                    }
            )
    }
}

extension View {
    func swipeToDismiss(_ isPresented: Binding<Bool>) -> some View {
        modifier(SwipeToDismiss(isPresented: isPresented))
    }
    
    func pinchToZoom() -> some View {
        modifier(PinchToZoom())
    }
    
    func panToMove() -> some View {
        modifier(PanToMove())
    }
}
