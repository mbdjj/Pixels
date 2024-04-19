//
//  DrawingView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

struct DrawingView: View {
    @State var model = DrawingViewModel(height: 8, width: 8)
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Clear") {
                    withAnimation {
                        model.pixels = Array(repeating: Array(repeating: Color.clear, count: model.width), count: model.height)
                    }
                }
                .padding(.horizontal)
            }
            
            Canvas(pixels: $model.pixels, selectedColor: $model.selectedColor, height: model.height, width: model.width)
                .padding()
            
            Spacer()
            
            HStack {
                ColorSquarePicker(colorValue: $model.selectedColor)
            }
            .padding()
        }
    }
}

#Preview {
    DrawingView()
}
