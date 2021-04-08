//
//  Extension+UIView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import Foundation
import UIKit
extension UIView {
    
    @IBInspectable
    var cornerRadiusValue: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
        var borderColor: UIColor? {
            get {
                if let color = layer.borderColor {
                    return UIColor(cgColor: color)
                }
                return nil
            }
            set {
                if let color = newValue {
                    layer.borderColor = color.cgColor
                } else {
                    layer.borderColor = nil
                }
            }
        }
    
    @IBInspectable
     var shadowRadius: CGFloat {
         get {
             return layer.shadowRadius
         }
         set {

            layer.shadowRadius = newValue
         }
     }
     @IBInspectable
     var shadowOffset : CGSize{

         get{
             return layer.shadowOffset
         }set{

             layer.shadowOffset = newValue
         }
     }

     @IBInspectable
     var shadowColor : UIColor{
         get{
             return UIColor.init(cgColor: layer.shadowColor!)
         }
         set {
             layer.shadowColor = newValue.cgColor
         }
     }
     @IBInspectable
     var shadowOpacity : Float {

         get{
             return layer.shadowOpacity
         }
         set {

             layer.shadowOpacity = newValue

         }
     } 
    
    
    enum ViewSide {
            case Left, Right, Top, Bottom
        }

        func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

            let border = CALayer()
            border.backgroundColor = color

            switch side {
            case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
            case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
            case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
            case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
            }

            layer.addSublayer(border)
        }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func viewShadow() {
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 3
        self.layer.shadowOffset =  .zero
        self.layer.shadowOpacity = 0.2
        self.borderWidth = 0.2
        self.borderColor = .black
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor(ciColor: .gray).cgColor
    }
    func viewShadowWithoutBorder() {
        //self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 3
        self.layer.shadowOffset =  .zero
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor(ciColor: .gray).cgColor
    }
    
}
