//
//  CustomRectangleView.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//
import SwiftUI

struct CustomRectangleView: View {
    let backgroundColor = Color(red: 244/255, green: 224/255, blue: 65/255)
    
    var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .frame(maxWidth: .infinity) // Stretch across the entire screen width
            .frame(height: 50)
            .overlay(
                Text("Working with GET request")
                    .font(.custom("NunitoSans-Regular", size: 20))
                    .lineSpacing(4)
                    .foregroundColor(.black)
            )
    }
}



#Preview {
    CustomRectangleView()
}
