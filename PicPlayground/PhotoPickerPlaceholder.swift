//
//  PhotoPickerPlaceholder.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 13.05.25.
//

import SwiftUI

struct PhotoPickerPlaceholder: View {
    var body: some View {
        VStack {
            Image(systemName: "photo.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.secondary)
            Text("No picture")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Text("Tap to import a photo")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    PhotoPickerPlaceholder()
}
