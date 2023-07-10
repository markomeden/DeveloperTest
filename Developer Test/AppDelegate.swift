//
//  AppDelegate.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import Localize_Swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        if let appLang = UserDefaults.standard.object(forKey: "appLanguage") as? String {
//            Localize.setCurrentLanguage(appLang)
////            Bundle.setLanguage(appLang)
//            print("applang = \(appLang)")
//        } else {
//            Localize.setCurrentLanguage("en")
//        }
        
        let locale = Locale.current
        if locale.language.languageCode?.identifier == "fr" {
            Localize.setCurrentLanguage("fr")
            AppManager.shared.setPreferredLanguage(language: "fr")
            print("Device language is French")
        } else {
            Localize.setCurrentLanguage("en")
            AppManager.shared.setPreferredLanguage(language: "en")
            print("Device language is not French")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

