//
//  Description.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import Foundation

struct Description: Codable {
    let id: Int?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
    }
}
