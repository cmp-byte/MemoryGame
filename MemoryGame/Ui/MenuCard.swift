//
//  MenuUi.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import SwiftUI

struct MenuCard: View {
    let emoji: String
    let title: String
    let onPressed: (Dificulty) -> Void
    var body: some View {
        VStack{
            Text(title).font(.largeTitle)
            Text(emoji)
            HStack{
                ForEach(Dificulty.allCases, content: { dificulty in
                    Text(dificulty.rawValue.capitalized).foregroundStyle(.blue).underline().onTapGesture {
                        onPressed(dificulty)
                    }
                })
            }
        }
    }
}


#Preview {
    MenuCard(emoji: ":)", title: "Titlu") { dificulty in

    }
}
