//
//  TokenResponse.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import Foundation

// Model for decoding API response that returns an authentication token
struct TokenResponse: Codable {
    let success: Bool    // Indicates whether the request was successful
    let token: String    // The authentication token provided by the server
}
