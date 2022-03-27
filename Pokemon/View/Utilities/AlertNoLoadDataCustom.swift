//
//  AlertNoLoadData.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 26/03/22.
//

import Foundation
import SwiftUI

struct AlertNoLoadDataCustom: ViewModifier {
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
    func alertNoDataLoadCustom(isPresented: Binding<Bool>, typeError: NetworkError) -> some View {
        return self.modifier(AlertNoLoadDataCustom(isPresented: isPresented, typeError: typeError))
    }
}
