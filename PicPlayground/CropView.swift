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
            
            EditingSlidersView()
        }
        
            
        
    }
}

#Preview {
    CropView()
}
