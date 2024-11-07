//
//  UploadButton.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI
import UIKit

struct SecondaryButton: View {
    let isActive: Bool
    @Binding var selectedImage: UIImage? // Binding connection to the image picker

    // Colors for different button states
    let activeColorText = Color(red: 0/255, green: 189/255, blue: 211/255)
    let disabledTextColor = Color(red: 116/255, green: 116/255, blue: 116/255)
    let pressedColor = Color(red: 230/255, green: 248/255, blue: 255/255)

    @State private var showConfirmationDialog = false
    @State private var showImagePicker = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack {
            Button(action: { showConfirmationDialog = true })
            {
                Text("Upload")
                    .font(.headline)
                    .foregroundColor(isActive ? activeColorText : disabledTextColor)
                    .frame(width: 100, height: 40)
            }
            .buttonStyle(UploadButtonStyle(
                pressedColor: pressedColor
            ))
            .confirmationDialog("Choose how you want to add a photo", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
                Button("Camera") {
                    imagePickerSourceType = .camera
                    showImagePicker = true
                }
                Button("Gallery") {
                    imagePickerSourceType = .photoLibrary
                    showImagePicker = true
                }
                Button("Cancel", role: .cancel) { }
            }
            .fullScreenCover(isPresented: $showImagePicker) {
                ImagePicker(
                    sourceType: imagePickerSourceType,
                    selectedImage: $selectedImage,
                    errorMessage: $errorMessage
                )
            }
        }
    }
}

struct UploadButtonStyle: ButtonStyle {
    let pressedColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                configuration.isPressed ? pressedColor : Color.clear
            )
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

//#Preview {
//    SecondaryButton(isActive:true, selectedImage: <#Binding<UIImage?>#>)
//}
