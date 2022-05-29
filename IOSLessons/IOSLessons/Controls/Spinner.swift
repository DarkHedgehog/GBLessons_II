//
//  Spinner.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 29.05.2022.
//

import UIKit

@IBDesignable
final class Spinner: UIView {

    /// Цвет точек
    @IBInspectable var spinCount: Int = 5 {
        didSet {
            sharedInit();
        }
    }

    /// Длительность цикла анимации
    @IBInspectable var loopDuration: Double = 1 {
        didSet {
            sharedInit();
        }
    }

    /// Расстояние по X между точками
    @IBInspectable var dotsInterval: Double = 3 {
        didSet {
            sharedInit();
        }
    }

    /// Основной цвет точек
    @IBInspectable var dotsColor: UIColor = UIColor.gray {
        didSet {
            sharedInit();
        }
    }

    /// Радиус точек
    @IBInspectable var dotsRadius: Double = 20 {
        didSet {
            sharedInit();
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit();
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit();
    }

    private func sharedInit() {
        layer.sublayers?.removeAll()
        layer.removeAllAnimations();

        let startedX = (frame.width / 2.0) - ((Double(spinCount) * (dotsRadius + dotsInterval)) / 2.0)
        let positionY = (frame.height / 2.0) - dotsRadius / 2.0
        let syncAnimationTime = CACurrentMediaTime();

        for i in 0..<spinCount {
            let positionX = startedX + (Double(i) * (dotsRadius + dotsInterval))
            let shapeLayer = spinnerDotLayer(CGRect(x: positionX, y: positionY, width: dotsRadius, height: dotsRadius))
            let dotAnimation = spinnerAnimation(syncTime: syncAnimationTime, index: i);

            shapeLayer.add(dotAnimation, forKey: "animateSpinner")
            layer.addSublayer(shapeLayer)
        }

    }

    private func spinnerDotLayer(_ rect: CGRect) -> CALayer {
        let circlePath = UIBezierPath(ovalIn: rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = dotsColor.cgColor
        shapeLayer.strokeColor = dotsColor.cgColor
        shapeLayer.opacity = 1
        shapeLayer.lineWidth = 1
        return shapeLayer
    }

    private func spinnerAnimation(syncTime: CFTimeInterval, index: Int) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.beginTime = syncTime + (loopDuration/Double(spinCount) * Double(index))
        animation.fromValue = 1
        animation.toValue = 0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = 1
        animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        return animation
    }


    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
}
