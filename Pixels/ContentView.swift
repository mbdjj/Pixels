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
                            .onTapGesture {
                                pixels[row][index] = .red
                            }
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    ContentView()
}
