//
//  NetworkManager.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = URL(string: "https://frontend-test-assignment-api.abz.agency/api/v1")!
    
    private init() {}
    
    // Function to fetch a list of users
    func getUsers(page: Int = 1, count: Int = 6, completion: @escaping (Result<UsersResponse, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/users")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "count", value: "\(count)")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let usersResponse = try decoder.decode(UsersResponse.self, from: data)
                completion(.success(usersResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Function to fetch a token
    func getToken(completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/token")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                completion(.success(tokenResponse.token))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Function to register a new user
    func registerUser(user: UserRegistrationData, completion: @escaping (Result<UserRegistrationResponse, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/users")
        
        // First, retrieve the token
        getToken { tokenResult in
            switch tokenResult {
            case .success(let token):
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue(token, forHTTPHeaderField: "Token")
                
                let boundary = "Boundary-\(UUID().uuidString)"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
                let httpBody = self.createBody(with: user, boundary: boundary)
                request.httpBody = httpBody
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    
                    guard let data = data else {
                        let error = NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let registrationResponse = try decoder.decode(UserRegistrationResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(registrationResponse))
                        }
                    } catch {
                        // Attempt to decode validation error message
                        if let errorResponse = try? decoder.decode(APIErrorResponse.self, from: data) {
                            let errorMessages = errorResponse.fails?.compactMap { "\($0.key): \($0.value.joined(separator: ", "))" }
                                .joined(separator: "\n") ?? errorResponse.message
                            let validationError = NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMessages])
                            DispatchQueue.main.async {
                                completion(.failure(validationError))
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(.failure(error))
                            }
                        }
                    }
                }
                
                task.resume()
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createBody(with user: UserRegistrationData, boundary: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"
        
        // Add name
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"name\"\(lineBreak)\(lineBreak)")
        body.append("\(user.name)\(lineBreak)")
        
        // Add email
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"email\"\(lineBreak)\(lineBreak)")
        body.append("\(user.email)\(lineBreak)")
        
        // Add phone
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"phone\"\(lineBreak)\(lineBreak)")
        body.append("\(user.phone)\(lineBreak)")
        
        // Add position_id
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"position_id\"\(lineBreak)\(lineBreak)")
        body.append("\(user.position_id)\(lineBreak)")
        
        // Add photo
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"photo.jpg\"\(lineBreak)")
        body.append("Content-Type: image/jpeg\(lineBreak)\(lineBreak)")
        body.append(user.photo)
        body.append(lineBreak)
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }

    struct APIErrorResponse: Decodable {
        let success: Bool
        let message: String
        let fails: [String: [String]]?
    }

    struct PositionsResponse: Codable {
        let success: Bool
        let positions: [Position]
    }

    struct Position: Codable {
        let id: Int
        let name: String
    }
    
    // Function to retrieve available positions
    func getPositions(completion: @escaping (Result<[Position], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/positions")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let positionsResponse = try decoder.decode(PositionsResponse.self, from: data)
                completion(.success(positionsResponse.positions))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}



