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
    @Published var showImagePicker = false
    
    @Published var selectedPositionID: Int?
    @Published var positions: [NetworkManager.Position] = []
    @Published var photo: UIImage?
    
    @Published var errorMessage: String?
    @Published var registrationSuccess = false // Validator for navigating to registration Success view
    @Published var registrationFalse = false // Validator for navigating to registration False view
    
    func fetchPositions() {
        NetworkManager.shared.getPositions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let positions):
                    self?.positions = positions
                    // Set the first position by default
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
        
        // Convert UIImage to Data
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
                    self?.objectWillChange.send()  // Notify of the change
                    self?.registrationSuccess = true
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.objectWillChange.send()  // Notify of the change
                    self?.registrationFalse = true
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Validation for form data fields before submission
    var isFormValid: Bool {
        return validateName && validateEmail && validatePhone && validPhoto() && selectedPositionID != nil
    }
    
    // Validation for photo
    func validPhoto() -> Bool {
        photo != nil ? true : false
    }
    
    // Validation for registration button
    var isButtonValid: Bool {
        return !name.isEmpty && !email.isEmpty && !phone.isEmpty
    }
    
    // Validation for name
    var validateName: Bool {
        name.count < 2 || name.count > 60 ? false : true
    }
    
    // Validation for email
    var validateEmail: Bool {
        let emailRegEx = #"^(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]+)@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    // Validation for phone
    var validatePhone: Bool {
        let phoneRegEx = #"^\+380\d{9}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: phone)
    }
}
