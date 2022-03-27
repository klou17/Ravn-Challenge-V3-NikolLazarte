//
//  AlertCustom.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 24/03/22.
//

import SwiftUI

struct AlertFailConexionCustom: ViewModifier {
    @Binding var isPresented: Bool
    let typeError: NetworkError
    let tryAgain: () -> ()
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(typeError.messageErrorTitle),
                    message: Text(typeError.messageErrorBody),
                    primaryButton: .cancel(Text("Try Again"), action: tryAgain),
                    secondaryButton: .default(Text("OK"))
                )
            }
    }
}

extension View {
    func alertFailConexionCustom(isPresented: Binding<Bool>, typeError: NetworkError, tryAgain: @escaping () -> () ) -> some View {
        return self.modifier(AlertFailConexionCustom(isPresented: isPresented, typeError: typeError, tryAgain: tryAgain))
    }
}
