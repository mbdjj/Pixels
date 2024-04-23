//
//  SettingsView.swift
//  Pixels
//
//  Created by Marcin Bartminski on 22/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("showGrid") var showGrid: Bool = false
    @AppStorage("useTransparency") var useTransparency: Bool = true
    @AppStorage("canvasSize") var canvasSize: Int = 8
    
    @AppStorage("pictureSize") var pictureSize: Int = 1024
    
    var body: some View {
        List {
            Section("Canvas") {
                Toggle(isOn: $showGrid) {
                    Label("Show grid", systemImage: "grid")
                }
                Toggle(isOn: $useTransparency) {
                    Label("Use transparency", systemImage: "photo.artframe")
                }
                Picker(selection: $canvasSize) {
                    Section {
                        Text("2x2").tag(2)
                        Text("4x4").tag(4)
                        Text("8x8").tag(8)
                        Text("16x16").tag(16)
                        Text("32x32").tag(32)
                    }
                    Section {
                        Text("3x3").tag(3)
                        Text("9x9").tag(9)
                        Text("27x27").tag(27)
                    }
                } label: {
                    Label("Canvas size", systemImage: "square.resize")
                }
                .onChange(of: canvasSize) { oldValue, newValue in
                    if oldValue % 3 == 0 && newValue % 2 == 0 || oldValue % 2 == 0 && newValue % 3 == 0 {
                        pictureSize = 0
                    }
                }
            }
            
            Section("Picture") {
                Picker(selection: $pictureSize) {
                    Text("Original").tag(0)
                    if canvasSize % 2 == 0 {
                        Text("64x64").tag(64)
                        Text("128x128").tag(128)
                        Text("256x256").tag(256)
                        Text("512x512").tag(512)
                        Text("1024x1024").tag(1024)
                    } else {
                        Text("243x243").tag(243)
                        Text("729x729").tag(729)
                    }
                } label: {
                    Label("Picture size", systemImage: "square.resize.up")
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
