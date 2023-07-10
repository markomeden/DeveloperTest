//
//  ServiceLabel.swift
//  Developer Test
//
//  Created by Marko Meden User on 08/07/2023.
//

enum ServiceType {
    case call
    case message
    case email
    case cancel
}

import UIKit
import Localize_Swift

class ServiceLabel: ClickableView {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!

    var itemPressed: (() -> Void)?
    
    private var view: UIView!

    
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
        view.layer.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 0.8).cgColor

        backgroundView.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
        self.onClickedDelegate = self
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ServiceLabel", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func configure(type: ServiceType) {
        switch type {
        case .call:
            title.text = "Call".localized()
            imageView.image = UIImage(named: "phone.fill")
        case .message:
            title.text = "Message".localized()
            imageView.image = UIImage(named: "bubble.middle.bottom.fill")
        case .email:
            title.text = "Email".localized()
            imageView.image = UIImage(named: "envelope.badge.fill")
        case .cancel:
            title.text = "Cancel".localized()
            imageView.image = UIImage(named: "multiply.circle.fill")
            
            title.textColor = UIColor(named: "SystemRed")
            imageView.tintColor = UIColor(named: "SystemRed")
        }
    }
}

extension ServiceLabel: OnViewClickedDelegate {
    func pressStarted(_ sender: UIView) {
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
    }
    
    func pressCanceled(_ sender: UIView) {
        backgroundView.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
    }
    
    func pressEnded(_ sender: UIView) {
        backgroundView.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        self.itemPressed?()
    }
}
