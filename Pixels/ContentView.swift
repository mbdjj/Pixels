//
//  ContentView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 17/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var pixels = Array(repeating: Array(repeating: Color.blue, count: 8), count: 8)
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 8, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< 8, id: \.self) { index in
                        pixels[row][index]
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .overlay {
            GeometryReader { proxy in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let location = value.location
                                let x = floor(location.x / proxy.size.width * 8)
                                let y = floor(location.y / proxy.size.height * 8)
                                
                                if x >= 0 && x < 8 && y >= 0 && y < 8 {
                                    pixels[Int(y)][Int(x)] = .red
                                }
                            }
                    )
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
