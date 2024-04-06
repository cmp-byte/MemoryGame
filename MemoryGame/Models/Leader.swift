//
//  Leader.swift
//  MemoryGame
//
//  Created by Razvan on 06.04.2024.
//

import Foundation

struct Leader: Identifiable {
    var name: String;
    var score: Int;
    var id: String {
        UUID().uuidString
    }

}
