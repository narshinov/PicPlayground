//
//  CropView.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 13.05.25.
//

import SwiftUI

struct CropView: View {
    
    let items = RotationIndicatorType.allCases
        
    var body: some View {
        VStack {
            Image(.mock)
                .resizable()
                .scaledToFit()
            
            HStack(spacing: 16) {
                ForEach(items, id: \.self) { type in
                    CircularIndicator(type: type, value: CGFloat.random(in: -1...1), isSelected: false)
                }
            }
        }
        
            
        
    }
}

#Preview {
    CropView()
}
