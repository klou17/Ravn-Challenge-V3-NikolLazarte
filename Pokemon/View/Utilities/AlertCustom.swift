//
//  AlertCustom.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 24/03/22.
//

import SwiftUI

struct AlertCustom: ViewModifier {
    @Binding var isPresented: Bool
    let typeError: NetworkError
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(typeError.messageErrorTitle),
                    message: Text(typeError.messageErrorBody),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

extension View {
    func alertCustom(isPresented: Binding<Bool>, typeError: NetworkError) -> some View {
        return self.modifier(AlertCustom(isPresented: isPresented, typeError: typeError))
    }
}
