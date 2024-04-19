//
//  ColorSquarePicker.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

struct ColorSquarePicker: View {
    
    @Binding var colorValue: Color
    
    var body: some View {
        colorValue
            .frame(width: 24, height: 24, alignment: .center)
            .overlay(Rectangle().stroke(Color.white, style: StrokeStyle(lineWidth: 4)))
            .padding(8)
            .background(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .pink]), center: .center))
            .overlay(ColorPicker("", selection: $colorValue).labelsHidden().opacity(0.015))
    }
}

#Preview {
    ColorSquarePicker(colorValue: .constant(.black))
}
