//
//  DrawingView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

struct DrawingView: View {
    @State var model: DrawingViewModel
    
    init() {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        self.model = DrawingViewModel(height: 8, width: 8, screenWidth: screenWidth)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Canvas(pixels: $model.pixels, selectedColor: $model.selectedColor, height: model.height, width: model.width)
                    .padding()
                
                Spacer()
                Button {
                    model.imagePixels = model.upscaledPixels()
                } label: {
                    Label("Generate Image", systemImage: "photo")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(0 ..< model.amount, id: \.self) { index in
                        if index < model.lastUsed.count {
                            model.lastUsed[index]
                                .frame(width: 40, height: 40, alignment: .center)
                                .onTapGesture { model.selectedColor = model.lastUsed[index] }
                        } else {
                            Color.clear
                                .frame(width: 40, height: 40, alignment: .center)
                        }
                    }
                    ColorSquarePicker(colorValue: $model.selectedColor)
                        .onChange(of: model.selectedColor) { _, newColor in
                            if let index = model.lastUsed.firstIndex(where: { color in
                                color.toHex() == newColor.toHex()
                            }) {
                                model.lastUsed.remove(at: index)
                            }
                            model.lastUsed.insert(newColor, at: 0)
                        }
                }
                .padding()
            }
            .toolbar {
                Button("Clear") {
                    withAnimation {
                        model.pixels = Array(repeating: Array(repeating: Color.clear, count: model.width), count: model.height)
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
            .navigationDestination(item: $model.imagePixels) { array in
                VStack {
                    if let image = UIImage(pixels: array, width: model.picSize, height: model.picSize) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        ShareLink(item: image, preview: SharePreview("Pixels Image", image: image))
                    }
                }
            }
        }
    }
}

#Preview {
    DrawingView()
}
