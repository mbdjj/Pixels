//
//  ContentView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 17/04/2024.
//

import SwiftUI

struct Canvas: View {
    
    @Binding var pixels: [[Color]]
    @Binding var selectedColor: Color
    
    let height: Int
    let width: Int
    
    let showMesh: Bool = false
    
    var body: some View {
        VStack(spacing: showMesh ? 1 : 0) {
            ForEach(0 ..< height, id: \.self) { row in
                HStack(spacing: showMesh ? 1 : 0) {
                    ForEach(0 ..< width, id: \.self) { index in
                        pixels[row][index]
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
        .overlay {
            GeometryReader { proxy in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let location = value.location
                                let x = floor(location.x / proxy.size.width * Double(width))
                                let y = floor(location.y / proxy.size.height * Double(height))
                                
                                if x >= 0 && x < Double(width) && y >= 0 && y < Double(height) {
                                    pixels[Int(y)][Int(x)] = selectedColor
                                }
                            }
                    )
            }
        }
        .border(Color.black, width: 4)
    }
}

#Preview {
    Canvas(pixels: .constant(Array(repeating: Array(repeating: Color.blue, count: 8), count: 8)), selectedColor: .constant(Color.black), height: 8, width: 8)
}
