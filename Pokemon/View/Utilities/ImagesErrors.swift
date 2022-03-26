//
//  ImagesErrors.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import SwiftUI

struct ImagesErrors: ViewModifier {
    let typeError: NetworkError?
    
    func body(content: Content) -> some View {
        ZStack {
            Color.systemBackground
            content
            
                if typeError == .failConexion {
                    VStack {
                        Image(systemName: "icloud.slash.fill")
                            .foregroundColor(Color.cellBackground)
                            .frame(width: 30, height: 30)
                    }
                    
                } else if typeError == nil {
                    content
                }
        }
    }
}

extension View {
    func imageErrorCustom(typeError: NetworkError) -> some View {
        return self.modifier(ImagesErrors(typeError: typeError))
    }
}
