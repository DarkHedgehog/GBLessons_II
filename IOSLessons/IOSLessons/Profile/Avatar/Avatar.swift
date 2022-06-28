//
//  Avatar.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit
import Kingfisher

@IBDesignable
class Avatar: UIControl {
    /// Радиус тени
    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    /// прозрачность тени
    @IBInspectable var shadowOpacity: Float = 0.7 {
       didSet {
           self.layer.shadowOpacity = shadowOpacity
       }
    }

    /// Цвет тени
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    var imageUrl: String? {
        didSet {
            sharedInit()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()

    }

    override init(frame: CGRect) {
       super.init(frame: frame)
        sharedInit()
    }

    fileprivate func sharedInit(){

        backgroundColor = UIColor.clear
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius

        let borderView = UIView()
        borderView.frame = bounds
        borderView.layer.cornerRadius = frame.width/2
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        addSubview(borderView)

        let otherSubContent = UIImageView()
        otherSubContent.image = UIImage(named: "DarkHedgehog")
        if let imageUrlString = imageUrl,
           let imageUrl = URL(string: imageUrlString) {

            otherSubContent.kf.setImage(with: imageUrl)
        }

        otherSubContent.frame = borderView.bounds
        borderView.addSubview(otherSubContent)

        self.isUserInteractionEnabled = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 5,
                       options: .curveLinear
        ) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }


}
