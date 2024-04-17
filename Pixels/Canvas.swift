//
//  ContentView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 17/04/2024.
//

import SwiftUI

struct Canvas: View {
    
    @State var pixels: [[Color]]
    
    let height: Int
    let width: Int
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
        
        self.pixels = Array(repeating: Array(repeating: Color.blue, count: width), count: height)
    }
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0 ..< height, id: \.self) { row in
                HStack(spacing: 1) {
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
                                    pixels[Int(y)][Int(x)] = .red
                                }
                            }
                    )
            }
        }
        .border(Color.black, width: 4)
        .padding()
    }
}

#Preview {
    Canvas(height: 16, width: 16)
}
