//
//  MenuScreen.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import SwiftUI

struct MenuScreen: View {
    
    @ObservedObject var menuViewModel : MenuViewModel = MenuViewModel()

    var body: some View {
        switch menuViewModel.model{
        case .error:
            Text("Failed Loading")
            Button(action: {menuViewModel.startLoading()}, label: {
                Text("Retry")
            })
        case .loading:
            ProgressView()
        case .idle(let themes):
            ForEach(themes) { theme in
                MenuCard(emoji: ":)", title: theme.nume, onPressed: { diff in
                    menuViewModel.selectGame(theme)
                })
            }
        case .inGame(_):
            GameScreen(viewModel: GameViewModel())
        }
    }
}

#Preview {
    MenuScreen()
}
