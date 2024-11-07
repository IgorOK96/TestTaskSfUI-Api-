//
//  Position.swift
//  TestTaskSfUI
//
//  Created by user246073 on 11/7/24.
//

import Foundation

// Represents a job position or role with a unique identifier and name
struct Position: Identifiable, Codable {
    let id: Int    // Unique identifier for the position
    let name: String    // Name or title of the position
}

// A response model for decoding API responses containing a list of positions
struct PositionResponse: Codable {
    let positions: [Position]    // Array of positions returned from the API
}
