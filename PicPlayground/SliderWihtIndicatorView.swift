//
//  SliderWihtIndicatorView.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 14.05.25.
//

import SwiftUI

struct SliderWihtIndicatorView: View {
    @State private var value: Int?
    @State private var isSelected: Bool = false
    
    private var indicatorValue: CGFloat {
        guard let value else { return .zero }
        return CGFloat(value)*0.05
    }
    
    var body: some View {
        VStack {
            CircularIndicator(
                type: RotationIndicatorType.horizontal,
                value: indicatorValue,
                isSelected: $isSelected
            )
            LinearSlider(currentIndex: $value)
        }
    }
}

#Preview {
    SliderWihtIndicatorView()
}
