//
//  MemoCard.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import Foundation
class MemoCard: Identifiable{
    let id: Int
    var isVisible: Bool
    var isMatched: Bool
    let data: String
    
    func flipMemoCard(){
        isVisible.toggle()
    }
    
    func makeMatch(){
        isMatched = true;
    }
    
    func isPair(_ memoCard : MemoCard) -> Bool{
        self.data == memoCard.data
    }
    
    init(id: Int = -1, isVisible: Bool = false, isMatched: Bool = false, data: String){
        self.id = id
        self.isVisible = isVisible
        self.isMatched = isMatched
        self.data = data
    }
}
