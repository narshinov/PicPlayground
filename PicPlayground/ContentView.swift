//
//  ContentView.swift
//  PicPlayground
//
//  Created by Никита Аршинов on 13.05.25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var imageData = Data(count: .zero)
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            if let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        SimultaneousGesture(
                            // Масштабирование
                            MagnificationGesture()
                                .onChanged { value in
                                    scale = lastScale * value
                                }
                                .onEnded { value in
                                    if scale < 1.0 {
                                        withAnimation(.spring()) {
                                            scale = 1.0
                                            lastScale = 1.0
                                            offset = .zero
                                            lastOffset = .zero
                                        }
                                    } else {
                                        lastScale = scale
                                    }
                                },
                            
                            // Перемещение
                            DragGesture()
                                .onChanged { gesture in
                                    if scale > 1 {
                                        offset = CGSize(
                                            width: lastOffset.width + gesture.translation.width,
                                            height: lastOffset.height + gesture.translation.height
                                        )
                                    }
                                }
                                    
                                .onEnded { gesture in
                                    lastOffset = offset
                                }
                        )
                    )
                
            } else {
                PhotosPicker(selection: $photoItem) {
                    PhotoPickerPlaceholder()
                }
            }
        }
        .onChange(of: photoItem) {
            loadImageData()
        }
    }
    
    private func loadImageData() {
        Task {
            do {
                guard
                    let data = try await photoItem?.loadTransferable(type: Data.self)
                else { return }
                imageData = data
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
