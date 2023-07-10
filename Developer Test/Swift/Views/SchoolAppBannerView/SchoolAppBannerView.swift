//
//  SchoolAppBannerView.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import Localize_Swift

@IBDesignable
class SchoolAppBannerView: UIView {

    private var view: UIView!
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var arrowsAngle: UIImageView!
    @IBOutlet weak var title: UILabel!

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
        
        title.text = "Schoolapp".localized()
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SchoolAppBannerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    func changeLanguage() {
        title.text = "Schoolapp".localized()
    }
}
