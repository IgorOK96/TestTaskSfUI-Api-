//
//  TabButton.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.

import SwiftUI

struct TabButton: View {
    let customColor = Color(red: 0/255, green: 189/255, blue: 211/255)
    let iconName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(isSelected ? customColor : .gray)
                Text(title)
                    .font(.headline)
                    .foregroundColor(isSelected ? customColor : .gray)
            }
            .padding()
        }
    }
}

#Preview {
    TabButton(iconName: "car", title: "User", isSelected: false, action: {})
}
