//
//  RadioButtonView.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

struct RadioButtonView: View {
    let customColor = Color(red: 0/255, green: 189/255, blue: 211/255)
    var label: String
    var isSelected: Bool

    var body: some View {
        HStack(spacing: 35) {
            ZStack {
                Circle()
                    .fill(isSelected ? customColor : Color.clear)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Circle()
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
            }
            Text(label)
                .font(.custom("NunitoSans-Regular", size: 20))
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

struct RadioButtonGroupView: View {
    @Binding var selectedPositionID: Int? // Binding with ViewModel
    var positions: [NetworkManager.Position] // Positions received from ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Select your position")
                .font(.custom("NunitoSans-Regular", size: 25))
            
            ForEach(positions, id: \.id) { position in
                RadioButtonView(
                    label: position.name,
                    isSelected: selectedPositionID == position.id
                )
                .onTapGesture {
                    selectedPositionID = position.id
                }
                .offset(x: 30)
            }
        }
        .padding()
    }
}
