//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published private (set) var model: CardGame
    
    var score : Int {model.score}
    var title: String
    
    @Published
    var remainingTime: Double = 0
    
    @Published
    var gameState: GameState = GameState.not_started
    
    var cardsColor: Color
    var cardsSymbol: String
    
    
    init() {
        self.model = CardGame(["z","x","y"])
        self.title = "Joc de memorie"
        self.cardsColor =  Color(red: 0.5, green: 0, blue: 0.5)
        self.cardsSymbol = "BackGround"
        
    }
    
    
    var cardsList: Array<Card> {
        model.cardsList
    }

    
    func chooseCard(_ chosenCard: Card){
        model.chooseCard(chosenCard)
        
    }
    
    func shuffleButton(){
        model.shuffleCards()
        updateTime()
        gameState = .in_progress
 
    }
    
    func updateTime() {
        let currentTime = NSDate().timeIntervalSince1970 * 1000
        remainingTime = 1 - ((currentTime - model.timeStartTimestamp) / (model.maxDurationSeconds * 1000))
        if (remainingTime <= 0) {
            model.attemptFinishGame()
        }
    
        if (model.isGameFinished) {
            if(model.isWon){
                gameState = .won
            }
            else{
                gameState = .lost
            }
        }

    }
 
}

enum GameState {
    case not_started, in_progress, lost, won
}


