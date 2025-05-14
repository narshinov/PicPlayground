//
//  EditingSlidersView.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 14.05.25.
//

import SwiftUI

struct EditingSlidersView: View {
    @State private var currentIndicatorIndex: Int?
    @State private var curentLinearIndex: Int?
        
    @State var models: [CircularIndicator.Model] = [
        .init(type: RotationIndicatorType.rotation, value: .zero),
        .init(type: RotationIndicatorType.vertical, value: .zero),
        .init(type: RotationIndicatorType.horizontal, value: .zero)
    ]
    
    private let contentMargin: CGFloat = (UIScreen.main.bounds.width - 64) / 2
    
    var body: some View {
        VStack {
            indicators
            LinearSlider(currentIndex: $curentLinearIndex)
        }
        .onAppear(perform: setupInitalPosition)
        .onChange(of: curentLinearIndex, setupIndicatorValue)
        .onChange(of: currentIndicatorIndex, setupIndicatorState)
    }
    
    private var indicators: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 32) {
                    ForEach(models.indices, id: \.self) { index in
                        CircularIndicator(model: models[index])
                            .id(index)
                            .onTapGesture {
                                goToNextIndicator(proxy, to: index)
                            }
                    }
                }
                .scrollTargetLayout()
            }
        }
        .contentMargins(.horizontal, contentMargin)
        .contentMargins(.vertical, 16)
        .scrollIndicators(.never)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $currentIndicatorIndex)
    }
    
    private func goToNextIndicator(_ proxy: ScrollViewProxy, to index: Int) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentIndicatorIndex = index
            proxy.scrollTo(index)
        }
    }
    
    private func setupInitalPosition() {
        currentIndicatorIndex = .zero
    }
    
    private func setupIndicatorState(_ oldValue: Int?, _ newValue: Int?) {
        guard let oldValue, let newValue else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            curentLinearIndex = Int((models[newValue].value/0.05).rounded())
            models[oldValue].isEdited = true
            models[newValue].isEdited = false
        }
    }
    
    private func setupIndicatorValue() {
        guard let currentIndicatorIndex, let curentLinearIndex else { return }
        models[currentIndicatorIndex].value = CGFloat(curentLinearIndex)*0.05
        if curentLinearIndex != 0 {
            models[currentIndicatorIndex].isEdited = false
        }
    }
}

#Preview {
    EditingSlidersView()
}
