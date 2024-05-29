// UIView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Добавление шиммера
extension UIView {
    /// Старт анимации шиммера
    /// - Parameters:
    ///   - animationSpeed: скорость анимации
    func shimmerOn(animationSpeed: TimeInterval = 2.5) {
        layoutIfNeeded()
        backgroundColor = .systemGray4
        layer.mask?.removeFromSuperlayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width * 2,
            height: bounds.width * 2
        )
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat(Float.pi / 2), 0, 0, 1)
        layer.mask = gradientLayer

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = animationSpeed
        animation.fromValue = -2 * bounds.width
        animation.toValue = 2 * bounds.width
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }

    /// Остановка анимации шиммера
    func shimmerOff() {
        backgroundColor = .clear
        layer.mask = nil
    }
}
