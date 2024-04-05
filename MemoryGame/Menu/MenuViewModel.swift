//
//  MenuViewModel.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import Foundation
class MenuViewModel: ObservableObject {
    @Published private (set) var model: MenuState
    
    init() {
        self.model = .loading
        startLoading()
    }

    func startLoading(){
        model = .loading
        //processing
        model = .idle(x: [GameTheme(nume: "Bazinga", id: 1)])
    }

    func selectGame(_ theme: GameTheme) {
        model = .inGame(x: theme)
    }

}
enum MenuState{
    case error, loading, idle(x: [GameTheme]), inGame(x: GameTheme)
}
