//
//  ContentView.swift
//  test
//
//  Created by Conrad Irwin on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Copy") {
            }
            .keyboardShortcut("c", modifiers: .command)
        }
    }
}

#Preview {
    ContentView()
}
