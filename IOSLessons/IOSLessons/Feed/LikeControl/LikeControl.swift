//
//  LikeControl.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit


fileprivate let HEART_LIKED_NAME = "heart.fill"
fileprivate let HEART_NOLIKED_NAME = "heart"

@IBDesignable
class LikeControl: UIControl {

    var likeCountLabel: UILabel = UILabel()
    var likedImage: UIImageView = UIImageView()

    @IBInspectable var likeCount: Int = 0 {
       didSet {
//           likeCountLabel.text = String(likeCount)
//           setNeedsDisplay()
           UIView.transition(with: likeCountLabel,
                             duration: 0.2,
                             options: .transitionFlipFromTop
           ) {
               self.likeCountLabel.text = "\(self.likeCount)"
           }

       }
    }

    @IBInspectable var isLiked: Bool  = false {
       didSet {
           updateHeartImage()
           setNeedsDisplay()
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

        backgroundColor = UIColor.green

        updateHeartImage()

        likedImage.frame = CGRect(x: 2, y: 4, width: frame.height-4, height: frame.height-8)
        likedImage.isUserInteractionEnabled = true
        likedImage.image = UIImage(systemName: HEART_LIKED_NAME)
//        likedImage.isHidden = !isLiked
        addSubview(likedImage)

        let countLabel = newLikeCountLabel(likeCount)
        likeCountLabel = countLabel
        addSubview(countLabel)

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


    private func newLikeCountLabel(_ count: Int) -> UILabel {
        let countLabel = UILabel()
        countLabel.frame = CGRect(x: likedImage.frame.width + 5,
                                           y: 0,
                                           width: frame.width - 10 - likedImage.frame.width,
                                           height: frame.height)


        countLabel.text = String(count)
        countLabel.textColor = .brown
        countLabel.textAlignment = .left
        countLabel.font = countLabel.font.withSize(40.0)
//        addSubview(countLabel)
        return countLabel
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for subview in subviews {
            for touch in touches {
                let point = touch.location(in: subview)
                if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                    if subview === likedImage {
                        isLiked = !isLiked
                        likeCount += isLiked ? +1 : -1
                        return
                    }
                }
            }
        }

    }
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        for subview in subviews {
//            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
//                if subview === likeImage {
//                    print (event?.type.hashValue)
//                    return true
//                }
//                return true
//            }
//        }
//        return false
//    }

    private func updateHeartImage() {
        likedImage.image = UIImage(systemName: isLiked ? HEART_LIKED_NAME : HEART_NOLIKED_NAME)
        likedImage.tintColor = isLiked ? .systemRed : .black
    }
}
