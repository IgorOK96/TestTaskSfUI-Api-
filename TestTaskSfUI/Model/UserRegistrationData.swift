//
//  UserRegistrationData.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import Foundation

// Model for encoding user registration data to be sent in an API request
struct UserRegistrationData: Codable {
    let name: String            // User's name
    let email: String           // User's email address
    let phone: String           // User's phone number
    let position_id: Int        // ID of the user's selected position or role
    let photo: Data             // Photo data in binary format (Data type)
}

// Model for decoding the API response after a user registration request
struct UserRegistrationResponse: Codable {
    let success: Bool           // Indicates if the registration was successful
    let user_id: Int            // Unique ID assigned to the newly registered user
    let message: String         // Message from the server about the registration result
}
