//
//  Environment.swift
//  Developer Test
//
//  Created by Marko Meden User on 10/07/2023.
//

import Foundation

import Foundation

public enum Environment {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static let teachersAPI: String = {
        guard let baseURL = Environment.infoDictionary["TEACHERS_API"] as? String else {
            fatalError("Root URL is invalid")
        }
        return baseURL
    }()
    
    static let schoolsAPI: String = {
        guard let baseURL = Environment.infoDictionary["SCHOOLS_API"] as? String else {
            fatalError("Root URL is invalid")
        }
        return baseURL
    }()
    
    static let studentsAPI: String = {
        guard let baseURL = Environment.infoDictionary["STUDENTS_API"] as? String else {
            fatalError("Root URL is invalid")
        }
        return baseURL
    }()
}
