//
//  PrimaryButton.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    let isActive: Bool

    // Colors for different button states
    let activeColor = Color(red: 244/255, green: 224/255, blue: 65/255)
    let inactiveTextColor = Color(red: 116/255, green: 116/255, blue: 116/255)
    let inactiveBackgroundColor = Color(red: 223/255, green: 223/255, blue: 223/255)
    let pressedColor = Color(red: 255/255, green: 200/255, blue: 0/255)

    var body: some View {
        Button(action: { if isActive { action() } }) {
            Text(title)
                .font(.headline)
                .foregroundColor(isActive ? .black : inactiveTextColor)
                .frame(width: 160, height: 50)
        }
        .buttonStyle(CustomButtonStyle(
            isActive: isActive,
            activeColor: activeColor,
            inactiveBackgroundColor: inactiveBackgroundColor,
            pressedColor: pressedColor
        ))
        .disabled(!isActive) // Disable the button if isActive is false
    }
}

struct CustomButtonStyle: ButtonStyle {
    let isActive: Bool
    let activeColor: Color
    let inactiveBackgroundColor: Color
    let pressedColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                isActive
                    ? (configuration.isPressed ? pressedColor : activeColor)
                    : inactiveBackgroundColor
            )
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

#Preview {
    PrimaryButton(title: "Sign up", action: {}, isActive: true)
}
