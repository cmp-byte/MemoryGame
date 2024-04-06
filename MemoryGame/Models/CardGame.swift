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
    private(set) var  attemptsLeft: Int = 0
    var timeStartTimestamp: Double = -1
    var maxDurationSeconds: Double = 0
    var isGameFinished: Bool = false
    let difficulty: Difficulty
    let title: String
    var wasSaved: Bool = false

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
    
    init(_ cardsDataList: Array<String>, dificulty: Difficulty, title: String) {
        var index = -2
        self.difficulty = dificulty
        self.cardsList = Array(cardsDataList.map({ cardData in
            index += 2
            return [Card(id: index ,data: cardData), Card(id : index + 1,data: cardData)]
        }).joined())
        self.title = title

        setDificulty()

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

        if self.difficulty == .hard{
            shuffleCards()
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
    private mutating func setDificulty (){
        switch (self.difficulty) {

        case .easy:
                    attemptsLeft = 10
                    maxDurationSeconds = Double(10 * self.cardsList.count)

        case .medium:
                    attemptsLeft = 7
                    maxDurationSeconds = Double(7 * self.cardsList.count)

        case .hard:
                    attemptsLeft = 5
                    maxDurationSeconds = Double(5 * self.cardsList.count)
        }
    }
    mutating func fullResetBoard(){
        cardsList.forEach { card in
            card.isVisible = false
            card.isMatched = false
        }
        score = 0
        isGameFinished = false
        setDificulty()
        wasSaved = false

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

    mutating func saveResult(name: String){
        guard isWon else {
            return
        }
        var original = UserDefaults.standard.dictionary(forKey: title) ?? Dictionary()
        original[name] = score
        UserDefaults.standard.setValue(original, forKey: title)
        wasSaved = true
    }

    mutating func attemptFinishGame() {
        if (getTimestamp() > finishTimestamp) {
            return
        }
        finishGame()
    }
    

    private mutating func finishGame(){
        isGameFinished = true
        switch difficulty {
        case .medium:
            self.score *= 2
        case .hard:
            self.score *= 4
        default:
            break
        }
    }

}
