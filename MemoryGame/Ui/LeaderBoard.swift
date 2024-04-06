//
//  LeaderBoard.swift
//  MemoryGame
//
//  Created by Razvan on 06.04.2024.
//

import SwiftUI

struct LeaderBoard: View {
    let names: [Leader]
    var body: some View {

        LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum:200)), GridItem(.flexible(minimum: 100, maximum:200))], content: {
            Text("Name").foregroundColor(.primary)
            Text("Score").foregroundColor(.primary)
            ForEach(names) { leader in
                Text(leader.name)
                Text(String(leader.score))
            }
        })
        Spacer()
    }


}
