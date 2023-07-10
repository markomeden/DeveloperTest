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
}
