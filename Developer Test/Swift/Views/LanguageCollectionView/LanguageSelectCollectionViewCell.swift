//
//  LanguageSelectCollectionViewCell.swift
//  Developer Test
//
//  Created by Marko Meden User on 09/07/2023.
//

import UIKit

class LanguageSelectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if AppManager.shared.getPreferredLanguage() == "en" {
            flag.image = UIImage(named: "United Kingdom")
        } else if AppManager.shared.getPreferredLanguage() == "fr" {
            flag.image = UIImage(named: "France")
        }
    }

    func setupCell(language: String) {
        if AppManager.shared.getPreferredLanguage() == "en" {
            flag.image = UIImage(named: "United Kingdom")
        } else if AppManager.shared.getPreferredLanguage() == "fr" {
            flag.image = UIImage(named: "France")
        }
    }
}
