//
//  Student.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import Foundation

struct Student: Codable {
    let id: Int
    let name: String
    let school_id: Int
    let grade: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case school_id = "school_id"
        case grade = "grade"
    }
}
