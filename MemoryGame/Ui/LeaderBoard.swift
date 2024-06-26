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
            if !names.isEmpty {
                Text("Name").foregroundColor(.primary).font(.title)
                Text("Score").foregroundColor(.primary).font(.title)
            }
            ForEach(names) { leader in
                Text(leader.name)
                Text(String(leader.score))
            }
        })
        Spacer()
    }


}
