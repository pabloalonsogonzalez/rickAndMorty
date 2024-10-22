//
//  BaseView.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI

struct BaseView<Content:View>: View {
    @ObservedObject var output: BaseOutput
    
    let content: Content
    
    @EnvironmentObject var presentedScreen: PresentedScreen
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(output: BaseOutput,
         @ViewBuilder content: () -> Content) {
        self.output = output
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            VStack {
                content
            }
        }
        .alert(output.alertMessage.title,
               isPresented: $output.alertMessage.isShowing,
               actions: {
            Button(output.alertMessage.actionText) {
                output.alertMessage.action?()
            }
            if let secondAction = output.alertMessage.secondActionText {
                Button(secondAction) {
                    output.alertMessage.secondAction?()
                }
            }
        }, message: {
            Text(output.alertMessage.message)
        })
        // Navigation -> change root screen
        .onChange(of: output.rootNavigation) { _, newValue in
            presentedScreen.currentScreen = newValue
        }
        .onChange(of: output.shouldDismiss) {
            if output.shouldDismiss {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
