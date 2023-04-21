//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Oleksii Leshchenko on 16.04.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
