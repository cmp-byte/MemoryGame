//
//  Dificulty.swift
//  MemoryGame
//
//  Created by Student on 05.04.2024.
//

import Foundation
enum Dificulty: String, CaseIterable {
    case easy, medium, hard
}

extension Dificulty: Identifiable {
    var id: String { rawValue }
}
