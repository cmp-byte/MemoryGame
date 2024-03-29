//
//  MemoryGameTests.swift
//  MemoryGameTests
//
//  Created by Student on 29.03.2024.
//

import XCTest
@testable import MemoryGame


final class MemoryGameTests: XCTestCase {
    
    func testFlip(){
        let card = Card(data: "")
        card.flipCard()
        XCTAssert(card.isVisible)
    }
    
    func testUnflip(){
        let card = Card(isVisible:true, data: "")
        card.flipCard()
        XCTAssert(!card.isVisible)
    }
    
    func testMatching(){
        let card1 = Card(data: "a")
        let card2 = Card(data: "a")
        XCTAssert(card1.matchCards(card2))
    }
    
    func testNotMatching(){
        let card1 = Card(data: "a")
        let card2 = Card(data: "b")
        XCTAssert(!card1.matchCards(card2))
    }
    
    func testCardGameInit(){
        let lista = ["a","b","c"]
        let cardGame = CardGame(lista)
        XCTAssert(cardGame.cardsList.count==lista.count*2)
        for c in lista{
            XCTAssert(cardGame.cardsList.filter({card in card.data == c}).count == 2)
        }
    }
    func testCardGameShuffle(){
        let lista = ["a","b","c"]
        let cardGame = CardGame(lista)
        var cardGameShuffled = cardGame
        cardGameShuffled.shuffleCards()
        for i in 0..<cardGame.cardsList.count{
            if cardGame.cardsList[i].data != cardGameShuffled.cardsList[i].data{
                return
            }
        }
        XCTAssert(false)
    }
    
    func testChoseCard(){
        var cardGame = CardGame(["a","b"])
        let card1 = cardGame.cardsList[0]
        let card2 = cardGame.cardsList[1]
        let card3 = cardGame.cardsList[3]
        cardGame.shuffleCards()
        cardGame.chooseCard(card1)
        XCTAssert(cardGame.cardsList.filter({ card in
            card.isVisible
        }).count == 1)
        
        // test to see that nothing happens if we choose the same card twice in a row
        cardGame.chooseCard(card1)
        XCTAssert(cardGame.cardsList.filter({ card in
            card.isVisible
        }).count == 1)
        
    
        cardGame.chooseCard(card3)
        cardGame.resetBoard()
        XCTAssert(cardGame.cardsList.filter({ card in
            card.isVisible
        }).count == 0)
        cardGame.chooseCard(card1)
        cardGame.chooseCard(card2)
        XCTAssert(cardGame.cardsList.filter({ card in
            card.isVisible  && card.isMatched
        }).count == 2)
    }

    func testFinishGame(){
        var cardGame = CardGame(["a","b"])
        let card1 = cardGame.cardsList[0]
        let card3 = cardGame.cardsList[3]
        cardGame.shuffleCards()
        for i in 0..<cardGame.attemptsLeft-1 {
            cardGame.chooseCard(card1)
            cardGame.chooseCard(card3)
            cardGame.resetBoard()
            XCTAssert(!cardGame.isGameFinished, "attempt \(i)")
        }
        
        cardGame.chooseCard(card1)
        cardGame.chooseCard(card3)
        XCTAssert(cardGame.isGameFinished, "\(cardGame.attemptsLeft)")
    }
    
    func testHotStreak(){
        var cardGame = CardGame(["a","b","c"])
        var card1 = cardGame.cardsList[0]
        var card2 = cardGame.cardsList[1]
        var card3 = cardGame.cardsList[2]
        var card4 = cardGame.cardsList[3]
        cardGame.shuffleCards()
        
        cardGame.chooseCard(card1)
        cardGame.chooseCard(card2)
        XCTAssert(cardGame.score==1)
        cardGame.chooseCard(card3)
        cardGame.chooseCard(card4)
        XCTAssert(cardGame.score==3)
    }
    
    func testHotStreakReset(){
        var cardGame = CardGame(["a","b","c"])
        
        var card1 = cardGame.cardsList[0]
        var card2 = cardGame.cardsList[1]
        var card3 = cardGame.cardsList[2]
        var card4 = cardGame.cardsList[3]
        var card5 = cardGame.cardsList[4]
        
        cardGame.shuffleCards()
        
        cardGame.chooseCard(card1)
        cardGame.chooseCard(card2)
        XCTAssert(cardGame.score==1)
        
        cardGame.chooseCard(card3)
        cardGame.chooseCard(card5)
        
        cardGame.chooseCard(card3)
        cardGame.chooseCard(card4)
        XCTAssert(cardGame.score==2)
    }
}
