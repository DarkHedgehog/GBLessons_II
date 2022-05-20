//
//  Avatar.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit

@IBDesignable
class Avatar: UIControl {

    var avatarImageView: UIImageView?

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()

    }

    override init(frame: CGRect) {
       super.init(frame: frame)
        sharedInit()
    }

    fileprivate func sharedInit(){
//        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0


        // add the border to subview
        let borderView = UIView()
        borderView.frame = bounds
        borderView.layer.cornerRadius = frame.width/2
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        addSubview(borderView)

        // add any other subcontent that you want clipped
        let otherSubContent = UIImageView()
        otherSubContent.image = UIImage(named: "DarkHedgehog")
        otherSubContent.frame = borderView.bounds
        borderView.addSubview(otherSubContent)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    /// Радиус тени
    @IBInspectable var shadowRadius: CGFloat = 4.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    /// прозрачность тени
    @IBInspectable var shadowOpacity: Float = 0 {
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
}
