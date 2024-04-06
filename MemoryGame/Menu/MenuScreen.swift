//
//  MenuScreen.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import SwiftUI
import GameSource

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
            NavigationView(content: {
                VStack {
                    ForEach(themes) { theme in
                        MenuCard(gameTheme: theme)
                    }
                }
            })
        }
    }
}

extension GameTheme: Identifiable {
    public var id: String {
        self.title
    }
}

#Preview {
    MenuScreen()
}