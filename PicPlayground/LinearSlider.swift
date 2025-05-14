//
//  RouletSlider.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 14.05.25.
//

import SwiftUI

struct LinearSlider: View {
    @Binding var currentIndex: Int?
    @State private var isScrolling = false
    @State private var scrollStopTimer: Timer?
    
    private let initialPosition = 0
    private let range = Range<Int>(-20...20)
    private let contentMargin: CGFloat = (UIScreen.main.bounds.width - 10) / 2
    
    private var selectionMarkerColor: Color {
        isScrolling ? .yellow : .black
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            linearScale
            selectionMarker
        }
        .contentMargins(.horizontal, contentMargin)
        .scrollIndicators(.never)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $currentIndex)
        .onChange(of: currentIndex, resetScrollStopTimer)
        .onAppear {
            currentIndex = initialPosition
        }
    }
    
    private var linearScale: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .bottom , spacing: .zero) {
                ForEach(range, id: \.self) { index in
                    VStack {
                        if index == .zero {
                            Circle()
                                .frame(width: 3)
                        }
                        Marker()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(index%10 == 0 ? .black : .gray)
                            .frame(width: 10, height: 15)
                            .id(index)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .sensoryFeedback(.increase, trigger: currentIndex)
    }
    
    private var selectionMarker: some View {
        Marker()
            .stroke(lineWidth: 2)
            .fill(selectionMarkerColor)
            .frame(width: 10, height: 35)
    }
    
    private func resetScrollStopTimer() {
        isScrolling = true
        scrollStopTimer?.invalidate()
        scrollStopTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                isScrolling = false
            }
        }
    }
}

#Preview {
    LinearSlider(currentIndex: .constant(.zero))
}

struct Marker: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: .init(x: rect.midX, y: rect.maxY))
        p.addLine(to: .init(x: rect.midX, y: rect.minY))
        return p
    }
}
