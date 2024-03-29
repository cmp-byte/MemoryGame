//
//  CardUi.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import SwiftUI

struct CardUi: View {
    let color: Color
    let text: String
    let match: Bool
    let face: Bool
    let cardSymbol: String
    
    var body: some View {
        let ob = if (match) {
            0.0
        } else {
            1.0
        }

        ZStack{
            RoundedRectangle(cornerRadius:20)
                .foregroundColor(color)
            if (face) {
                Text(text).font(.largeTitle)
            } else {
                Text(cardSymbol).font(.largeTitle)
            }

        }.opacity(ob)
    }
}

#Preview {
    CardUi(color: Color.blue,text: "front",match: false, face: true, cardSymbol: "back")
}

