//
//  ColorPokemon.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import SwiftUI

enum ColorPokemon: String {
    case black
    case blue
    case brown
    case gray
    case green
    case pink
    case purple
    case red
    case white
    case yellow
    
    var color: Color {
        switch self {
        case .black:
            return .pBlack
        case .blue:
            return .pBlue
        case .brown:
            return .pBrown
        case .gray:
            return .pGray
        case .green:
            return .pGreen
        case .pink:
            return .pPink
        case .purple:
            return .pPurple
        case .red:
            return .pRed
        case .white:
            return .pWhite
        case .yellow:
            return .pYellow
        }
    }
}
