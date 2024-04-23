//
//  DrawingViewModel.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

@Observable class DrawingViewModel {
    let width: Int
    let height: Int
    let useTransparency: Bool
    
    var pixels: [[Color]]
    var selectedColor: Color = .black
    
    var amount: Int
    var lastUsed: [Color] = [.black]
    
    var picSize: Int
    var imagePixels: [Pixel]? = nil
    var previewSize: Int {
        width % 2 == 0 ? 128 : 243
    }
    
    init(canvasSize: Int, pictureSize: Int, useTransparency: Bool, screenWidth: CGFloat) {
        self.width = canvasSize
        self.height = canvasSize
        
        self.useTransparency = useTransparency
        
        self.pixels = Array(repeating: Array(repeating: useTransparency ? Color.clear : Color.white, count: canvasSize), count: canvasSize)
        let amount = Int(floor((screenWidth - 32) / 40)) - 1
        self.amount = amount
        
        self.picSize = pictureSize
    }
    
    func upscaledPixels(isPreview: Bool = false) -> [Pixel] {
        var pixels = self.pixels.map { $0.map { color in Pixel(from: color) } }
        let picSize: Int = isPreview ? self.previewSize : self.picSize
        
        if picSize == 0 {
            return pixels.joined().map { $0 }
        } else if picSize % 2 == 0 {
            for _ in 0 ..< Int(log2(Double(picSize / width))) {
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
        } else {
            for _ in 0 ..< Int(log3(Double(picSize / width))) {
                var iterationPixels = [[Pixel]]()
                for i in 0 ..< pixels.count {
                    iterationPixels.append([Pixel]())
                    iterationPixels.append([Pixel]())
                    iterationPixels.append([Pixel]())
                    for j in 0 ..< pixels[i].count {
                        iterationPixels[3 * i].append(pixels[i][j])
                        iterationPixels[3 * i].append(pixels[i][j])
                        iterationPixels[3 * i].append(pixels[i][j])
                        iterationPixels[3 * i + 1].append(pixels[i][j])
                        iterationPixels[3 * i + 1].append(pixels[i][j])
                        iterationPixels[3 * i + 1].append(pixels[i][j])
                        iterationPixels[3 * i + 2].append(pixels[i][j])
                        iterationPixels[3 * i + 2].append(pixels[i][j])
                        iterationPixels[3 * i + 2].append(pixels[i][j])
                    }
                }
                pixels = iterationPixels
            }
        }
        print("\(pixels.count) \(pixels[0].count)")
        print(pixels.joined().map { $0 }.count)
        return pixels.joined().map { $0 }
    }
    
    private func log3(_ val: Double) -> Double {
        return log(val)/log(3.0)
    }
}
