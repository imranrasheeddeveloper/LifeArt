//
//  RoundedView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import Foundation
import UIKit
@IBDesignable
public class RoundedView: UIView {

    @IBInspectable public var topLeft: Bool = false      { didSet { setNeedsLayout() } }
    @IBInspectable public var topRight: Bool = false     { didSet { setNeedsLayout() } }
    @IBInspectable public var bottomLeft: Bool = false   { didSet { setNeedsLayout() } }
    @IBInspectable public var bottomRight: Bool = false  { didSet { setNeedsLayout() } }
    @IBInspectable public var cornerRadius: CGFloat = 0  { didSet { setNeedsLayout() } }

    public override func layoutSubviews() {
        super.layoutSubviews()

        var options = UIRectCorner()

        if topLeft     { options.formUnion(.topLeft) }
        if topRight    { options.formUnion(.topRight) }
        if bottomLeft  { options.formUnion(.bottomLeft) }
        if bottomRight { options.formUnion(.bottomRight) }

        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: options,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
