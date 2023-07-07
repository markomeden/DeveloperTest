//
//  Schools.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import Foundation

struct School: Codable {
    let id: Int?
    let name: String
    let image_url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image_url = "image_url"
    }
}
