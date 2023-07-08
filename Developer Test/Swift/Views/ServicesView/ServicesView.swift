//
//  ServicesView.swift
//  Developer Test
//
//  Created by Marko Meden User on 08/07/2023.
//

import UIKit

protocol ServiceLabelDelegate : AnyObject {
    func cancelPressed()
}

@IBDesignable
class ServicesView: UIView {

    private var view: UIView!
    
    @IBOutlet weak var serviceLabel1: ServiceLabel!
    @IBOutlet weak var serviceLabel2: ServiceLabel!
    @IBOutlet weak var serviceLabel3: ServiceLabel!
    @IBOutlet weak var serviceLabel4: ServiceLabel!
    
    weak var delegate: ServiceLabelDelegate?
    
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
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        serviceLabel1.configure(type: .call)
        serviceLabel2.configure(type: .message)
        serviceLabel3.configure(type: .email)
        serviceLabel4.configure(type: .cancel)
        
        serviceLabel4.itemPressed = {
            self.delegate?.cancelPressed()
        }
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ServicesView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
