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
    let cardSymbol: String
    var rotation : Double
    var face: Bool
    
    init(color: Color, text: String, match: Bool, cardSymbol: String, face: Bool) {
        self.color = color
        self.text = text
        self.match = match
        self.cardSymbol = cardSymbol
        self.face = face
        self.rotation = face ? 0 : 180
        
    }
    
    var animatableData: Double{
        get { rotation}
        set { rotation = newValue }
    }
    
    var body: some View {
        let ob = if (match) {
            0.0
        } else {
            1.0
        }
        
        ZStack{
            RoundedRectangle(cornerRadius:20)
                .foregroundColor(color)
            if (rotation > 90) {
                Text(cardSymbol).font(.largeTitle)
                
            } else {
                Text(text).font(.largeTitle)
            }
            
        }.opacity(ob).rotation3DEffect(
            Angle.degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

#Preview {
    CardUi(color: Color.blue,text: "front",match: false,  cardSymbol: "back", face: false)
}

