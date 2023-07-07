//
//  Teacher.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import Foundation

struct Teacher: Codable {
    let id: Int
    let name: String
    let school_id: Int
    let class_: String
    let image_url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case school_id = "school_id"
        case class_ = "class"
        case image_url = "image_url"
    }
}
