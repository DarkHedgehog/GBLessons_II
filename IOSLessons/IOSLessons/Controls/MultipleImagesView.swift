//
//  MultipleImagesView.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 06.06.2022.
//

import UIKit

@IBDesignable
class MultipleImagesView: UIView {



//    @IBInspectable
    public var imageNames = [String]()

    public var delegate: MultipleImagesViewDelegate?

    private var images = [UIImageView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func loadImagesNamed(_ imageNames: [String]) {
        self.imageNames = imageNames

        for imageView in images {
            imageView.removeFromSuperview()
        }

        images = [UIImageView]()

        var index = 0
        let baseFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        for imageName in imageNames {
            if index >= 4 { break }
            let newImage = UIImage.init(named: imageName)

            let newImageRect = calculateRectForImage(index: index, totalOf: imageNames.count, frame: baseFrame)
            let newImageView = UIImageView.init(frame: newImageRect)
            newImageView.clipsToBounds = true
            newImageView.contentMode = .scaleAspectFill
            newImageView.layer.borderWidth = 3
            newImageView.layer.borderColor = UIColor.systemBackground.cgColor
            newImageView.image = newImage
            newImageView.isUserInteractionEnabled = true
            newImageView.bounds = newImageRect

            images.append(newImageView)
            addSubview(newImageView)

            index = index + 1
        }

        layer.cornerRadius = 10
        layer.masksToBounds = true
        isUserInteractionEnabled = true
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {


        guard let delegate = delegate else { return }

        for subview in images {
            for touch in touches {
                let point = touch.location(in: subview)
                if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                    delegate.tapOnImage(frame: subview.frame)


                    return;

                }
            }
        }





    }

    private func calculateRectForImage(index: Int, totalOf: Int, frame: CGRect) -> CGRect {

        if totalOf == 1 {
            return CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        } else if totalOf == 2 {
            return CGRect(x: frame.origin.x, y: (frame.height / 2.0) * Double(index), width: frame.width, height: frame.height / 2.0)
        } else if totalOf == 3 {
            if index == 0 {
                return CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
            } else {
                return calculateRectForImage(index: index - 1, totalOf: 2, frame:
                    CGRect(x: frame.width / 2.0, y: 0, width: frame.width / 2.0, height: frame.height)
                )
            }
        } else if totalOf == 4 {
            let yScale = (2.0/3.0)
            if index == 0 {
                return CGRect(x: 0, y: 0, width: frame.width, height: frame.height * yScale)
            } else {
                return CGRect(x: (frame.width / 3.0) * Double(index-1), y: frame.height * yScale, width: frame.width / 3.0, height: frame.height - frame.height * yScale)
            }
        }
        return frame
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadImagesNamed(["nature-0x0A", "nature-0x01", "nature-0x03", "nature-0x04"])
    }
}
