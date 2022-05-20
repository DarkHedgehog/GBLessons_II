//
//  LikeControl.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit

@IBDesignable

class LikeControl: UIControl {

    var likeCountLabel: UILabel = UILabel()
    var likeImage: UIImageView = UIImageView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()

    }

    override init(frame: CGRect) {
       super.init(frame: frame)
        sharedInit()
    }

    fileprivate func sharedInit(){

        backgroundColor = UIColor.lightGray


        likeImage.image = UIImage(systemName: "heart.fill")
        likeImage.tintColor = .systemRed
        likeImage.frame = CGRect(x: 2, y: 4, width: frame.height-4, height: frame.height-8)
        addSubview(likeImage)

        likeCountLabel.frame = CGRect(x: likeImage.frame.width + 5,
                                           y: 0,
                                           width: frame.width - 10 - likeImage.frame.width,
                                           height: frame.height)


        likeCountLabel.text = String(likeCount)
        likeCountLabel.textColor = .brown
        likeCountLabel.textAlignment = .left
        likeCountLabel.font = likeCountLabel.font.withSize(40.0)
//        likeCount.layer.borderWidth = 1
        addSubview(likeCountLabel)

        layer.cornerRadius = 8

        clipsToBounds = true

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

    /// прозрачность тени
    @IBInspectable var likeCount: Int = 0 {
       didSet {
           likeCountLabel.text = String(likeCount)
           setNeedsDisplay()
       }
    }

}
