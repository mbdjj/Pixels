//
//  PixelsApp.swift
//  Pixels
//
//  Created by Marcin Bartminski on 17/04/2024.
//

import SwiftUI

@main
struct PixelsApp: App {
    var body: some Scene {
        WindowGroup {
            Canvas(height: 8, width: 8)
        }
    }
}
