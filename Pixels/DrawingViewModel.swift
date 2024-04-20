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
    
    init(height: Int, width: Int, screenWidth: CGFloat) {
        self.height = height
        self.width = width
        
        self.pixels = Array(repeating: Array(repeating: Color.clear, count: width), count: height)
        let amount = Int(floor((screenWidth - 32) / 40)) - 1
        self.amount = amount
    }
}
