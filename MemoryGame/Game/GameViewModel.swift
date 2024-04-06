//
//  GameViewModel.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import SwiftUI
import GameSource

class GameViewModel: ObservableObject {
    @Published private (set) var model: CardGame
    
    var score : Int {model.score}
    var title: String
    var leaderBoard : [Leader] = []

    @Published
    var remainingTime: Double = 0
    
    @Published
    var gameState: GameState = GameState.not_started
    
    var cardsColor: Color
    var cardsSymbol: String
    var wasSaved: Bool {return self.model.wasSaved}

    
    init(gameTheme: GameTheme, dificulty: Difficulty) {
        self.model = CardGame(gameTheme.symbols, dificulty: dificulty, title: gameTheme.title)
        self.title = gameTheme.title
        self.cardsColor =  gameTheme.color
        self.cardsSymbol = gameTheme.card_symbol
        updateLeaderboard()
    }
    
    
    var cardsList: Array<Card> {
        model.cardsList
    }

    func updateLeaderboard () {
        self.leaderBoard = UserDefaults.standard.dictionary(forKey: self.title).map({ dict in
            dict.map { (key: String, value: Any) in
                Leader(name: key, score: value as! Int)
            }
        }) ?? []
        leaderBoard =  leaderBoard.sorted(by: { $0.score > $1.score })
    }

    func savePlayer(name: String){
        model.saveResult(name: name)
        updateLeaderboard()
    }

    func chooseCard(_ chosenCard: Card){
        model.chooseCard(chosenCard)
        
    }
    
    func shuffleButton(){
        model.shuffleCards()
        updateTime()
        gameState = .in_progress
 
    }


    func resetGameButton(){
        model.fullResetBoard()
        gameState = .not_started
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


