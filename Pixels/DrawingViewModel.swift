//
//  DrawingViewModel.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

@Observable class DrawingViewModel {
    let height: Int
    let width: Int
    
    var pixels: [[Color]]
    var selectedColor: Color = .black
    
    var amount: Int
    var lastUsed: [Color] = [.black]
    
    let picSize: Int = 1024
    
    init(height: Int, width: Int, screenWidth: CGFloat) {
        self.height = height
        self.width = width
        
        self.pixels = Array(repeating: Array(repeating: Color.white, count: width), count: height)
        let amount = Int(floor((screenWidth - 32) / 40)) - 1
        self.amount = amount
    }
    
    func upscaledPixels() -> [Pixel] {
        var pixels = self.pixels.map { $0.map { color in Pixel(from: color) } }
        for iteration in 0 ..< Int(log2(Double(picSize / width))) {
            var iterationPixels = [[Pixel]]()
            for i in 0 ..< pixels.count {
                iterationPixels.append([Pixel]())
                iterationPixels.append([Pixel]())
                for j in 0 ..< pixels[i].count {
                    iterationPixels[2 * i].append(pixels[i][j])
                    iterationPixels[2 * i].append(pixels[i][j])
                    iterationPixels[2 * i + 1].append(pixels[i][j])
                    iterationPixels[2 * i + 1].append(pixels[i][j])
                }
            }
            pixels = iterationPixels
        }
        print("\(pixels.count) \(pixels[0].count)")
        print(pixels.joined().map { $0 }.count)
        return pixels.joined().map { $0 }
    }
}
