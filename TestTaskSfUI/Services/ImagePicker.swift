//
//  ImagePicker.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    @Binding var errorMessage: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            
            // Get the selected image
            if let image = info[.originalImage] as? UIImage,
               let imageData = image.jpegData(compressionQuality: 1.0) {
                
                // Check file size (no larger than 5 MB)
                let fileSizeInMB = Double(imageData.count) / (1024 * 1024)
                guard fileSizeInMB <= 5 else {
                    parent.selectedImage = nil
                    return
                }
                
                // Check resolution (at least 70x70 pixels)
                let width = image.size.width
                let height = image.size.height
                guard width >= 70 && height >= 70 else {
                    parent.selectedImage = nil
                    return
                }
                
                // Check image format (jpeg/jpg)
                guard let imageType = imageType(from: imageData), imageType == "jpeg" else {
                    parent.selectedImage = nil
                    return
                }
                
                // If all checks pass, set the image
                parent.errorMessage = nil
                parent.selectedImage = image
            } else {
                parent.selectedImage = nil
            }
        }
        
        private func imageType(from data: Data) -> String? {
            let values = [UInt8](data.prefix(2))
            if values == [0xFF, 0xD8] { return "jpeg" }
            return nil
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
//#Preview {
//    ImagePicker()
//}
