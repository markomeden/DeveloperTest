//
//  TeacherCardTableViewCell.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit

class TeacherCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileFullName: UILabel!
    @IBOutlet weak var profileClass: UILabel!
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityText: UILabel!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactLabel: UILabel!
    
    var inset: CGFloat = 8
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.y += inset
            frame.size.height -= 2 * inset
            
            frame.origin.x += 24
            frame.size.width -= 2 * 24
            
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func setupCorners() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        contactView.layer.cornerRadius = 10
        contactView.layer.masksToBounds = true
        frontView.layer.cornerRadius = 10
        frontView.layer.masksToBounds = true
    }
    
    func setupCell(teacher: Teacher) {
        
    }
}
