//
//  SignResultView.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

struct SignResultView: View {
    let valid: Bool

    @State private var navigateToMain = false // Navigation activator

    var body: some View {
        VStack(spacing: 15) {
            Image(valid ? "TrueRegister" : "FalseRegister")
            Text(valid ? "User successfully registered" :
                    "That email is already registered")
            .font(.custom("NunitoSans-Regular", size: 20))
            
            PrimaryButton(title: valid ? "Got it" : "Try again", action: {
                    navigateToMain = true  // Navigate to the main screen
            }, isActive: true)
            .navigationDestination(isPresented: $navigateToMain) {
                TabBarView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignResultView(valid: false)
}
