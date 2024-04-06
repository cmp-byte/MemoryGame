//
//  MenuViewModel.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import Foundation
import GameSource
class MenuViewModel: ObservableObject {
    @Published private (set) var model: MenuState
    
    init() {
        self.model = .loading
        startLoading()
    }

    func startLoading(){
        model = .loading
        Task.init {
            do {
                model = .idle(x: try await GameSource.getRemote())
            } catch {
                model = .error
            }
        }
    }

}
enum MenuState{
    case error, loading, idle(x: [GameTheme])
}
