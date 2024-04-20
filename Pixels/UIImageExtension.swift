//
//  UIImageExtension.swift
//  Pixels
//
//  Created by Marcin Bartminski on 20/04/2024.
//

import SwiftUI

struct Pixel {
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
    
    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self.a = a
        self.r = r
        self.g = g
        self.b = b
    }
    
    init(from color: Color) {
        let ciColor = CIColor(color: UIColor(color))
        self.a = UInt8(ciColor.alpha * 255)
        self.r = UInt8(ciColor.red * 255)
        self.g = UInt8(ciColor.green * 255)
        self.b = UInt8(ciColor.blue * 255)
    }
}

extension UIImage {
    convenience init?(pixels: [Pixel], width: Int, height: Int) {
        guard width > 0 && height > 0, pixels.count == width * height else { return nil }
        var data = pixels
        guard let providerRef = CGDataProvider(data: Data(bytes: &data, count: data.count * MemoryLayout<Pixel>.size) as CFData) else { return nil }
        guard let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: width * MemoryLayout<Pixel>.size,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent)
        else { return nil }
        self.init(cgImage: cgim)
    }
}

extension UIImage: Transferable {
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { image in
            if let pngData = image.pngData() {
                return pngData
            } else {
                // Handle the case where UIImage could not be converted to png.
                throw ConversionError.failedToConvertToPNG
            }
        }
    }
    
    enum ConversionError: Error {
        case failedToConvertToPNG
    }
}


