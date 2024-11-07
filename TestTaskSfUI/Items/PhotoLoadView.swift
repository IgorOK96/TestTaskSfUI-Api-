//
//  FotoButton.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

struct PhotoLoadView: View {
    @Binding var selectedImage: UIImage? // Binding for Image Picker
    @Binding var isValid: Bool // Binding for validator to activate error state
    var isUploaded: Bool {
        selectedImage == nil
    }
    
    let customColor = Color(red: 0/255, green: 189/255, blue: 211/255)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(height: 65)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(!isValid  ? .red : .gray, lineWidth: 1)
                    )
                VStack {
                    HStack {
                        Text(!isUploaded ? "Photo uploaded" : "Upload your photo")
                            .font(.custom("NunitoSans-Regular", size: 20))
                            .foregroundColor(!isValid ? .red : .gray)
                        
                        Spacer()
                        SecondaryButton(isActive: true, selectedImage: $selectedImage)
                            .offset(x: 2)
                            .font(.headline)
                            .foregroundColor(customColor)
                    }
                    .offset(y: 15)
                    .padding()
                    Text("Photo is required")
                        .font(.custom("NunitoSans-Regular", size: 15))
                        .foregroundColor(!isValid ? .red : .clear)
                        .offset(x: -105, y: 10)
                }
            }
        }
        .padding()
    }
}


//struct PhotoLoadView_Previews: PreviewProvider {
//    @State static var isValidPreview = false // Пример начального значения
//    @State static var isValidPrview = false // Пример начального значения
//
//
//    static var previews: some View {
//        PhotoLoadView(isValid: $isValidPreview, selectedImage: $viewboe)
//    }
//}
