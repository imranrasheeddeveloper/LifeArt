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

extension UIView {
    
    func inputContainerView(image: UIImage? = nil, textField: UITextField? = nil) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87
        view.addSubview(imageView)
        
        
        if let textField = textField {
            
            imageView.centerY(inView: view)
            imageView.anchor(left: view.leftAnchor, paddingLeft: 8, width: 24, height: 24)
            
            view.addSubview(textField)
            textField.centerY(inView: view)
            textField.anchor(left: imageView.rightAnchor, bottom: view.bottomAnchor,
                             right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
            
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        view.addSubview(separatorView)
        separatorView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                             right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    //This fucntion creates constraints programmatically
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0,
                paddingBottom: CGFloat? = 0,
                paddingRight: CGFloat? = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.masksToBounds = false
    }
}

extension UITextField {
    
    func textField(withPlaceholder placeholder: String, isSecureTextField: Bool) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = isSecureTextEntry
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        return textField
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let customBlackColor = UIColor.rgb(red: 33, green: 33, blue: 33)
    static let customBlueColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    
    static let progressLayerColor = UIColor.rgb(red: 234, green: 46, blue: 111)
    static let trackLayerColor = UIColor.rgb(red: 56, green: 25, blue: 49)
    static let pulsatingLayerColor = UIColor.rgb(red: 86, green: 30, blue: 63)
    
    static let twitterBlue = UIColor.rgb(red: 73, green: 160, blue: 236)
    static let customRed = UIColor.rgb(red: 220, green: 78, blue: 65)
    static let customPurple = UIColor.rgb(red: 128, green: 87, blue: 194)
}




extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIView {
    
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    public func roundCorner() {
        let height = self.bounds.height
        self.layer.cornerRadius = height/2
        self.clipsToBounds = true
    }
}

extension UIColor {
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            
            return UIColor.magenta
        }
        
        var rgb: UInt32 = 0
        Scanner.init(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
   
}
extension UIView {

   func roundCorners(corners:CACornerMask, radius: CGFloat) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = corners
   }
}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

//extension UIView {
//
//    func applyShadowOnView(_ view: UIView) {
//        view.layer.cornerRadius = 8
//        view.layer.shadowColor = UIColor.darkGray.cgColor
//        view.layer.shadowOpacity = 2
//        view.layer.shadowOffset = .zero
//        view.layer.shadowRadius = 5
//    }
//}
extension UIView {


func dropShadow2() {

    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 2, height: 3)
    layer.masksToBounds = false

    layer.shadowOpacity = 0.3
    layer.shadowRadius = 3
    //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.rasterizationScale = UIScreen.main.scale
    layer.shouldRasterize = true
}}

public extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.4) {
         UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
         })
     }
    func fadeOut(duration: TimeInterval = 0.4) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
      }
  }
//extension UIView {
//
//    func applyShadowOnView2(_ view:UIView) {
//
//            view.layer.cornerRadius = 8
//            view.layer.shadowColor = UIColor.darkGray.cgColor
//            view.layer.shadowOpacity = 1
//            view.layer.shadowOffset = CGSize.zero
//            view.layer.shadowRadius = 5
//
//    }
//}
//extension UIView {
//
//  // OUTPUT 1
//  func dropShadow3(scale: Bool = true) {
//    layer.masksToBounds = false
//    layer.shadowColor = UIColor.black.cgColor
//    layer.shadowOpacity = 0.5
//    layer.shadowOffset = CGSize(width: -1, height: 1)
//    layer.shadowRadius = 1
//
//    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//  }
//
//  // OUTPUT 2
//  func dropShadow4(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//    layer.masksToBounds = false
//    layer.shadowColor = color.cgColor
//    layer.shadowOpacity = opacity
//    layer.shadowOffset = offSet
//    layer.shadowRadius = radius
//
//    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//  }
//}
