//
//  RegistrationViewModel.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var selectedPositionID: Int?
    @Published var positions: [NetworkManager.Position] = []
    @Published var photo: UIImage?
    

    @Published var showImagePicker = false
    @Published var errorMessage: String?
    @Published var registrationSuccess = false
    @Published var registrationFalse = false
    
   func fetchPositions() {
            NetworkManager.shared.getPositions { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let positions):
                        self?.positions = positions
                        // Устанавливаем первую позицию по умолчанию
                        if self?.selectedPositionID == nil, let firstPosition = positions.first {
                            self?.selectedPositionID = firstPosition.id
                        }
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    
    func registerUser() {
        guard let positionID = selectedPositionID, let photoImage = photo else {
            return
        }
        
        // Конвертируем UIImage в Data
        guard let photoData = photoImage.jpegData(compressionQuality: 0.9) else {
            return
        }
               
        let userData = UserRegistrationData(
            name: name,
            email: email,
            phone: phone,
            position_id: positionID,
            photo: photoData
        )
        
        NetworkManager.shared.registerUser(user: userData) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.objectWillChange.send()  // Уведомляем об изменении
                    self?.registrationSuccess = true
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.objectWillChange.send()  // Уведомляем об изменении
                    self?.registrationFalse = true
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    var isFormValid: Bool {
        return validateName && validateEmail && validatePhone && validPhoto() && selectedPositionID != nil
    }
    
    func validPhoto() -> Bool {
        photo != nil ? true : false
    }
    
    var isButtonValid: Bool {
        return !name.isEmpty && !email.isEmpty && !phone.isEmpty
    }

    var validateName: Bool {
        name.count < 2 || name.count > 60 ? false : true
}
    
    var validateEmail: Bool {
    let emailRegEx = #"^(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]+)@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$"#
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: email)
}
    
    var validatePhone: Bool {
        let phoneRegEx = #"^\+380\d{9}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: phone)
    }
}
