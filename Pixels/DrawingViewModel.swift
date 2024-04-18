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
    
    init(height: Int, width: Int) {
        self.height = height
        self.width = width
        
        self.pixels = Array(repeating: Array(repeating: Color.clear, count: width), count: height)
    }
}
