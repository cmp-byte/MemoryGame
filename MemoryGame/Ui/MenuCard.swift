//
//  MenuUi.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import SwiftUI
import GameSource

struct MenuCard: View {
    let gameTheme: GameTheme

    var body: some View {
        VStack{
            Text(gameTheme.title).font(.largeTitle)
            Text(gameTheme.card_symbol)
            HStack{
                ForEach(Difficulty.allCases, content: { dificulty in
                    NavigationLink(destination: GameScreen(viewModel: GameViewModel(gameTheme: gameTheme, dificulty: dificulty))) { Text(dificulty.rawValue.capitalized).foregroundColor(ColorScheme.link.color).underline()
                    }
                })
            }
        }
    }
}
