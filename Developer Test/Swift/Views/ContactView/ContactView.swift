//
//  ContactView.swift
//  Developer Test
//
//  Created by Marko Meden User on 08/07/2023.
//

import UIKit
import Localize_Swift

protocol ContactViewDelegate : AnyObject {
    func buttonPressed()
}

@IBDesignable
class ContactView: UIView {

    private var view: UIView!
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileClass: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var universityTitle: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    @IBOutlet weak var contactButton: BlueButton!
    
    weak var delegate: ContactViewDelegate?
    
    // MARK: - Public Variables
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    // MARK: - Private Setup
    
    private func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        view.backgroundColor = UIColor.clear
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ContactView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setupContact(teacher: Teacher?, student: Student?, school: School?, description: Description?) {
        if let t = teacher {
            profileImage.sd_setImage(with: URL(string: t.image_url ), placeholderImage: UIImage(named: "Izidor"))
            profileName.text = t.name
            profileClass.text = "\("Class:".localized()) \(t.class_)"
        }
        
        if let s = student {
            profileImage.image = UIImage(named: "Izidor")
            profileName.text = s.name
            profileClass.text = "Student".localized()
        }
        
        if let sc = school {
            universityImage.sd_setImage(with: URL(string: sc.image_url))
            universityTitle.text = sc.name
        }
        
        if let d = description {
            profileDescription.text = d.description
        }
    }
    
    @IBAction func contactPressed(_ sender: Any) {
        delegate?.buttonPressed()
    }
}
