//
//  TeacherCardTableViewCell.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import SDWebImage
import Localize_Swift

protocol ContactCellDelegate : AnyObject {
    func buttonPressed(index: Int)
}

class TeacherCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileFullName: UILabel!
    @IBOutlet weak var profileClass: UILabel!
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityText: UILabel!
    @IBOutlet weak var contactButton: BlueButton!
    
    var inset: CGFloat = 8
    
    var teacher: Teacher?
    var school: School?
    var description_: Description?
    var student: Student?
    var index: Int?
    
    weak var delegate: ContactCellDelegate?
    
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
        contactButton.setTitle("Contact".localized(), for: .normal)
        contactButton.becomeFirstResponder()
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

        frontView.layer.cornerRadius = 10
        frontView.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = true
    }
    
    func setupCell(teacher: Teacher) {
        self.teacher = teacher
        profileImage.sd_setImage(with: URL(string: teacher.image_url), placeholderImage: UIImage(named: "Izidor"))
        profileFullName.text = teacher.name
        profileClass.text = teacher.class_ + " teacher".localized()
        contactButton.setTitle("Contact".localized(), for: .normal)
    }
    
    func setupCell(student: Student) {
        self.student = student
        profileImage.image = UIImage(named: "Izidor")
        profileFullName.text = student.name
        profileClass.text = "Student".localized()
    }
    
    func setupCell(school: School) {
        universityText.text = school.name
        universityImage.sd_setImage(with: URL(string: school.image_url), placeholderImage: UIImage(named: "Izidor"))
    }
    
    func setupCell(description: Description) {
        self.description_ = description
    }
    
    func setupIndex(index: Int) {
        self.index = index
    }
    
    @IBAction func contactCellDelegate(_ sender: Any) {
        delegate?.buttonPressed(index: index!)
    }
}
