//
//  CardGame.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import Foundation
struct CardGame{
    var cardsList: Array<Card>
    private(set) var score: Int = 0
    private(set) var  attemptsLeft: Int = 10
    var timeStartTimestamp: Double = -1
    let maxDurationSeconds: Double
    var isGameFinished: Bool = false
    private var hotStreak: Int = 0
    var isWon: Bool{
        cardsList.filter { card in
            card.isMatched }.count == cardsList.count
    }
    var finishTimestamp: Double {
        timeStartTimestamp + maxDurationSeconds * 1000
    }
    var isGameStarted: Bool {
        timeStartTimestamp != -1
    }
    
    init(_ cardsDataList: Array<String>) {
        var index = -2
        self.cardsList = Array(cardsDataList.map({ cardData in
            index += 2
            return [Card(id: index ,data: cardData), Card(id : index + 1,data: cardData)]
        }).joined())
        maxDurationSeconds = Double(10 * self.cardsList.count)
        
    }
    
    mutating func shuffleCards(){
        timeStartTimestamp = getTimestamp()
        cardsList.shuffle()
    }
    
    mutating func chooseCard(_ chosenCard: Card){
        guard attemptsLeft > 0 else {
            return
        }
        guard isGameStarted else {
            return
        }
        guard !isGameFinished else{
            return
        }
        if (getNoVisibleCards() == 2) {
            resetBoard()
        }
        guard !chosenCard.isVisible else{
            return
        }
        let alreadyChosen = cardsList.first { current in
            current.isVisible == true && current.isMatched == false
        }
        
        chosenCard.flipCard()
    
        guard let unwrapped = alreadyChosen else {
            return
        }
        
        if unwrapped.matchCards(chosenCard) {
            unwrapped.isMatched = true
            chosenCard.isMatched = true
            keepScore()
            return
        }
        
        decrementAttempts()
        
    }
    mutating func resetBoard(){
        cardsList.filter({ card in
            card.isVisible && !card.isMatched
        }).forEach { card in
            card.isVisible = false
        }
    }
    
    func getNoVisibleCards() -> Int {
        return cardsList.filter({ card in
            card.isVisible && !card.isMatched
        }).count
    }
    
    private func getTimestamp() -> Double {
        NSDate().timeIntervalSince1970 * 1000
    }
    
    private mutating func decrementAttempts(){
        self.attemptsLeft -= 1
        self.hotStreak = 0
        if (attemptsLeft<=0){
            finishGame()
        }
    }
    private mutating func keepScore(){
        score += 1 + hotStreak
        hotStreak += 1
        if (cardsList.filter({ card in
            card.isVisible && card.isMatched
        }).count == cardsList.count ) {
            finishGame()
        }
    }
    
    mutating func attemptFinishGame() {
        if (getTimestamp() > finishTimestamp) {
            return
        }
        finishGame()
    }
    
    private mutating func finishGame(){
        isGameFinished = true  }
    
}
