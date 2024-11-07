//
//  Untitled.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//
/*
# Users List and Registration App

This SwiftUI application allows users to register and view existing users, demonstrating networking, form validation, and pagination.

## Configuration Options
- **Base URL**: You can modify the `baseURL` in `NetworkManager.swift` if the endpoint changes.
- **Page Size**: Adjust the number of users per page by changing the `count` parameter in `getUsers()` in `NetworkManager.swift`.
- **Validation Rules**: Customize validation logic in `RegistrationViewModel.swift`.

## Dependencies
- **SwiftUI**: Native UI framework used for layout and views.
- **Combine**: For reactive programming, especially in managing network request states and validations.

## Common Issues and Troubleshooting
- **Network Connectivity**: If users are not loading, check your internet connection or the server endpoint.
- **Image Loading**: Ensure user-uploaded photos are of acceptable format and size, as specified in the registration requirements.
- **Validation Errors**: If registration fails, double-check field validations (e.g., email format, phone format) as defined in `RegistrationViewModel.swift`.

## Getting Started
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/your-repo.git
 
 
 Code Structure
 
     1.    Views
     •    UsersView.swift: Displays the list of users.
     •    SignUpView.swift: Manages the user registration process.
     2.    View Models
     •    UsersViewModel.swift: Handles data fetching and pagination for UsersView.
     •    RegistrationViewModel.swift: Manages form validation and registration logic in SignUpView.
     3.    Networking
     •    NetworkManager.swift: Contains methods for fetching users, registering new users, and retrieving token-based authenticatio
 
 ---

 
NetworkManager.swift
Users and Registration App

This file manages all network requests, including user fetching, token retrieval, and user registration.
API used: https://frontend-test-assignment-api.abz.agency/api/v1


 import Foundation

 class NetworkManager {
     // Singleton instance for shared network access
     static let shared = NetworkManager()
     private let baseURL = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1")!
     
     // Fetches a list of users with pagination support
     func getUsers(page: Int = 1, count: Int = 6, completion: @escaping (Result<UsersResponse, Error>) -> Void) {
         ...
     }
     
     // Fetches a registration token required for user registration
     func getToken(completion: @escaping (Result<String, Error>) -> Void) {
         ...
     }
 }
 */
