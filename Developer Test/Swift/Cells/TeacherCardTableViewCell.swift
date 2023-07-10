//
//  TeacherCardTableViewCell.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import SDWebImage
import Localize_Swift

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
    
    var teacher: Teacher?
    var school: School?
    var description_: Description?
    var student: Student?
    
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
        contactLabel.text = "Contact".localized()
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
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
    }
    
    func setupCell(teacher: Teacher, school: School, description: Description) {
        self.teacher = teacher
        self.school = school
        self.description_ = description
        
        profileImage.sd_setImage(with: URL(string: teacher.image_url), placeholderImage: UIImage(named: "Izidor"))
        profileFullName.text = teacher.name
        profileClass.text = teacher.class_ + " teacher"
        universityText.text = school.name
        universityImage.sd_setImage(with: URL(string: school.image_url), placeholderImage: UIImage(named: "Izidor"))
        contactLabel.text = "Contact".localized()
    }
    
    func setupCell(student: Student, school: School, description: Description) {
        self.student = student
        self.school = school
        self.description_ = description
        
        profileImage.image = UIImage(named: "Izidor")
        profileFullName.text = student.name
        profileClass.text = "Student".localized()
        universityText.text = school.name
        universityImage.sd_setImage(with: URL(string: school.image_url), placeholderImage: UIImage(named: "Izidor"))
        contactLabel.text = "Contact".localized()
    }
}
