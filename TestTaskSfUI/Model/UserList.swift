//
//  User.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import Foundation

// Model for decoding API response containing user data and pagination details
struct UsersResponse: Codable {
    let success: Bool           // Indicates if the request was successful
    let page: Int               // Current page number
    let total_pages: Int        // Total number of pages available
    let total_users: Int        // Total number of users in the dataset
    let count: Int              // Number of users on the current page
    let links: Links            // URLs for navigating to the next or previous pages
    let users: [User]           // Array of user data for the current page
}

// Model representing an individual user with basic details
struct User: Codable, Equatable {
    let id: Int                 // Unique identifier for the user
    let name: String            // User's name
    let email: String           // User's email address
    let phone: String           // User's phone number
    let position: String        // User's job position or role
    let photo: String           // URL string for the user's photo
}

// Model for pagination links, allowing navigation to the next or previous page
struct Links: Codable {
    let next_url: String?       // URL for the next page, if available
    let prev_url: String?       // URL for the previous page, if available
}
