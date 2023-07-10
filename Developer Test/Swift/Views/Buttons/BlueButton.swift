import UIKit

@IBDesignable
class BlueButton: UIButton {
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFont()
    }
    
    override func prepareForInterfaceBuilder() {
        backgroundColor = blueButtonColor
        setupCornerRadius()
    }
    
    override func awakeFromNib() {
        backgroundColor = blueButtonColor
        setupCornerRadius()
    }

    @IBInspectable var blueButtonColor: UIColor = UIColor(named: "BlueButton")! {
        didSet {
            backgroundColor = blueButtonColor
        }
    }

    func setupFont(size: CGFloat = 16) {
        self.clipsToBounds = true
        self.setTitleColor(.white ,for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    @IBInspectable override var bounds: CGRect {
        didSet {
            setupCornerRadius()
        }
    }
    
    func setupCornerRadius() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
}
