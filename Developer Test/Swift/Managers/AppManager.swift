//
//  AppManager.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import Foundation
import UIKit

class AppManager {
    static let shared = AppManager()
    
    func instantiateViewController(viewController: String, storyboard: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: viewController)
    }
}
