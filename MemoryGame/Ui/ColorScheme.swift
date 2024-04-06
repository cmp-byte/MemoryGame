//
//  ColorScheme.swift
//  MemoryGame
//
//  Created by Razvan on 06.04.2024.
//

import SwiftUI

enum ColorScheme {
    case text, link, error;

    var color : Color {
        switch self {
        case .text: return Color("MyColor")
        case .link: return Color("Link")
        case .error: return Color("Err")
        }
    }

}


