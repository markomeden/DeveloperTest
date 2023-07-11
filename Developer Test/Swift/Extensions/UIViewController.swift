//
//  UIViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 11/07/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorDialogNoInternet() {
        let alert = UIAlertController(title: "Alert", message: "No Internet", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
