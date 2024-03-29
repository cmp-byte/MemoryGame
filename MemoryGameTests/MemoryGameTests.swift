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
}
