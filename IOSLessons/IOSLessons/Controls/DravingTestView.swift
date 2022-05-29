//
//  Avatar.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 20.05.2022.
//

import UIKit

@IBDesignable

class DravingTestView: UIControl {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let colorBG: CGColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        let colorStroke: CGColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        context.setFillColor(colorBG)
        context.setStrokeColor(colorStroke)

        let rectangle = CGRect(x: rect.width/2,
                               y: rect.height/2,
                               width: rect.height/3,
                               height: rect.height/3)
        context.fill(rectangle)

        context.move(to: CGPoint(x: rect.width/2, y: 0))
        context.addLine(to: CGPoint(x: rect.width/2, y: rect.height/2))
        context.addLine(to: CGPoint(x: 0, y: rect.height/2))
        context.closePath()
        context.strokePath()
    }

}
