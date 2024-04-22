//
//  DrawingView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

struct DrawingView: View {
    @State var model: DrawingViewModel = DrawingViewModel(canvasSize: 8, pictureSize: 1024, useTransparency: true, screenWidth: 300)
    
    @AppStorage("showGrid") var showGrid: Bool = false
    @AppStorage("useTransparency") var useTransparency: Bool = true
    @AppStorage("canvasSize") var canvasSize: Int = 8
    @AppStorage("pictureSize") var pictureSize: Int = 1024
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    
    var body: some View {
        NavigationStack {
            VStack {
                Canvas(pixels: $model.pixels, selectedColor: $model.selectedColor, width: model.width, height: model.height)
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
                Button("Clear", role: .destructive) {
                    model = DrawingViewModel(canvasSize: canvasSize, pictureSize: pictureSize, useTransparency: useTransparency, screenWidth: screenWidth)
                }
                
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "switch.2")
                }
            }
            .navigationDestination(item: $model.imagePixels) { array in
                VStack {
                    if let image = UIImage(pixels: array, width: model.picSize, height: model.picSize) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .draggable(image)
                            .padding()
                        ShareLink(item: image, preview: SharePreview("Pixels Image", image: image))
                        Spacer()
                    }
                }
            }
            .onAppear {
                if canvasSize != model.width || useTransparency != model.useTransparency {
                    model = DrawingViewModel(canvasSize: canvasSize, pictureSize: pictureSize, useTransparency: useTransparency, screenWidth: screenWidth)
                } else if pictureSize != model.picSize {
                    model.picSize = pictureSize
                }
            }
        }
    }
}

#Preview {
    DrawingView()
}
