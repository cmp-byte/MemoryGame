//
//  Card.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import Foundation
class Card: Identifiable{
    let id: Int
    var isVisible: Bool
    var isMatched: Bool
    let data: String
    
    
    func flipCard(){
        isVisible.toggle()
    }
    
    func makeMatch(){
        isMatched = true
    }
    func  matchCards(_ card : Card) -> Bool {
        self.data ==  card.data
    }
    init(id: Int = -1, isVisible: Bool = false, isMatched: Bool = false, data: String) {
        self.isVisible = isVisible
        self.isMatched = isMatched
        self.data = data
        self.id = id;
    }
}
