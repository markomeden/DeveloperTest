//
//  DetailsViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 07/07/2023.
//

import UIKit
import Localize_Swift

class DetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contactView: ContactView!
    let servicesView = ServicesView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var teacher: Teacher?
    var school: School?
    var description_: Description?
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesView.delegate = self
        
        contactView.delegate = self
        contactView.setupContact(teacher: teacher, student: student, school: school, description: description_)
        
        backButton.setTitle("Back".localized(), for: .normal)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController : ContactViewDelegate {
    func buttonPressed() {
        self.view.addSubview(servicesView)
    }
}

extension DetailsViewController : ServiceLabelDelegate {
    func cancelPressed() {
        servicesView.removeFromSuperview()
    }
}
