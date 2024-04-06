//
//  MenuScreen.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import SwiftUI
import GameSource

struct MenuScreen: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass

    @ObservedObject var menuViewModel : MenuViewModel = MenuViewModel()

    var body: some View {
        switch menuViewModel.model{
        case .error:
            Text("Failed Loading").foregroundColor(ColorScheme.error.color).font(.largeTitle)
            Button(action: {menuViewModel.startLoading()}, label: {
                Text("Retry").foregroundColor(ColorScheme.link.color).font(.title)
            })
        case .loading:
            ProgressView()
        case .idle(let themes):
            NavigationView(content: {

                switch(verticalSizeClass) {
                case .compact:
                    HStack {
                        ForEach(themes) { theme in
                            MenuCard(gameTheme: theme).padding()
                        }
                    }
                default:
                    VStack {
                        ForEach(themes) { theme in
                            MenuCard(gameTheme: theme).padding()
                        }
                    }
                }
            }).navigationViewStyle(StackNavigationViewStyle())
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
