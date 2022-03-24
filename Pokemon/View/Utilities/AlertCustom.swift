//
//  AlertCustom.swift
//  Pokemon
//
//  Created by Nikol Lazarte on 24/03/22.
//

//import SwiftUI
//
//struct AlertCustom: ViewModifier {
//    
//    func body(content: Content) -> some View {
//        content
//            .alert(item: $networkError) { error in
//                Alert(
//                    title: Text(error.userMessageTitle),
//                    message: Text(error.userMessageDescription),
//                    dismissButton: .default(Text("Ok"), action: dismissAction)
//                )
//            }
//    }
//}
//
//extension View {
//    func alertCustom(networkError: Binding<NetworkError?>, dismissAction: @escaping () -> Void) -> some View {
//        modifier(FailedToLoadDataAlert(
//            networkError: networkError,
//            dismissAction: dismissAction
//        ))
//    }
//}
//
