//
//  CircleImage.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit



class CircleImage: UIImageView {

    

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
//        self.layer.cornerRadius = self.frame.width/2
//        self.clipsToBounds = true
    }


}
