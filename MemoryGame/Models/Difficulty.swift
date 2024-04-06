//
//  Dificulty.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import Foundation
enum Difficulty: String, CaseIterable {
    case easy, medium, hard
}

extension Difficulty: Identifiable {
    var id: String { rawValue }
}
