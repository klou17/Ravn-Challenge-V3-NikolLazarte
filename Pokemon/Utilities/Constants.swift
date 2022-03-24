//
//  Constants.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 21/03/22.
//

import Foundation
import UIKit

struct Constants {
    enum Network {
        static let graphqlURL = "https://dex-server.herokuapp.com/"
        static let pokeApiURL = "https://pokeapi.co/api/v2"
    }
    
    enum ListCell {
        static let cornerRadius = 16.0
        static let sizeSprite: CGFloat = 80
        static let sizeType: CGFloat = 50
        static let paddingLeadingSprite: CGFloat = -40
        static let paddingTrailingSprite: CGFloat = 10
        static let paddingTrailingType: CGFloat = -5
        static let paddingTrailingCell: CGFloat = 24
        static let paddingLeadingCell: CGFloat = 48
        static let paddingInfoCell: CGFloat = 8
    }
    
    enum ErrorText {
        static let wasError = "There was an Error"
        static let connectivityIssue = "Connectivity Issue"
        static let failLoadData = "Failed to Load Data"
        static let problemToConnect = "There is a problem trying to connect.\nPlease check your connectivity."
    }
    
    enum DetailView {
        static let sizeSpriteFront: CGFloat = 150
        static let cornerRadiusBgBody: CGFloat = 30
        static let paddingTopBody: CGFloat = 10
        static let widthType: CGFloat = 130
        static let heightType: CGFloat = 50
        static let paddingPicker: CGFloat = 18
        static let paddingNameId: CGFloat = 15
        static let paddingGeneration: CGFloat = 8
    }
    
}
