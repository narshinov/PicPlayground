//
//  RotationIndicators.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 14.05.25.
//

import SwiftUI

struct RotationIndicators: View {
    
    private var rotationValue: CGFloat = .zero
    private var verticalValue: CGFloat = .zero
    private var horizontalValue: CGFloat = .zero
    
    @State private var isRotetionSelected = false
    @State private var isVerticalSelected = false
    @State private var isHorizontalSelected = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: .zero) {
                CircularIndicator(
                    type: RotationIndicatorType.rotation,
                    value: rotationValue,
                    isSelected: $isRotetionSelected
                )
                
                CircularIndicator(
                    type: RotationIndicatorType.vertical,
                    value: verticalValue,
                    isSelected: $isVerticalSelected
                )
                
                CircularIndicator(
                    type: RotationIndicatorType.horizontal,
                    value: horizontalValue,
                    isSelected: $isHorizontalSelected
                )
            }
        }
    }
}

#Preview {
    RotationIndicators()
}
