//
//  DrawingView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 18/04/2024.
//

import SwiftUI

struct DrawingView: View {
    @State var model = DrawingViewModel(height: 8, width: 8)
    
    var body: some View {
        VStack {
            Canvas(pixels: $model.pixels, height: model.height, width: model.width)
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    DrawingView()
}
