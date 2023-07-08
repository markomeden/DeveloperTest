import UIKit

protocol OnViewClickedDelegate: AnyObject {
    func pressStarted(_ sender: UIView)
    func pressEnded(_ sender: UIView)
    func pressCanceled(_ sender: UIView)
}

class ClickableView: UIView {
    
    weak var onClickedDelegate: OnViewClickedDelegate?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.onClickedDelegate?.pressStarted(self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.onClickedDelegate?.pressCanceled(self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.onClickedDelegate?.pressStarted(self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if self.frame.contains(touch.location(in: self.superview)) {
                self.onClickedDelegate?.pressEnded(self)
            } else {
                self.onClickedDelegate?.pressCanceled(self)
            }
        }
    }
    
    public func roundCorners() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
    }
}
