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
    
    static let baseURL: String = {
        guard let baseURL = Environment.infoDictionary["SERVER_URL"] as? String else {
            fatalError("Root URL is invalid")
        }
        return baseURL
    }()
    
    static let webPayURL: String = {
        guard let webPayURL = Environment.infoDictionary["WEBPAY_URL"] as? String else {
            fatalError("Webpay URL is invalid")
        }
        return webPayURL
    }()
    
    static let versionText: String = {
        guard let versionText = Environment.infoDictionary["APP_VERSION_TEXT"] as? String else {
            fatalError("Root URL is invalid")
        }
        return versionText
    }()
    
    static let version: String = {
        return "\((Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!)"
    }()
    
    static let buildVersion: String = {
        return "\((Bundle.main.infoDictionary!["CFBundleVersion"] as? String)!)"
    }()
}
