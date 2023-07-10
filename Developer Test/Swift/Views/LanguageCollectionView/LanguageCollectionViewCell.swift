//
//  LanguageCollectionViewCell.swift
//  Developer Test
//
//  Created by Marko Meden User on 09/07/2023.
//

import UIKit

struct Language {
    let flag: String
    let name: String
}

class LanguageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(language: Language) {
        self.flag.image = UIImage(named: language.flag)
        self.title.text = language.name.uppercased()
    }

}
