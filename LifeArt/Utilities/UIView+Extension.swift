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

var imageCahce = [String: UIImage]()
extension UIImageView {
    
    func loadProfileImage(with urlString: String) {
        
        //check if image exists within the image cahce
        
        if let cachedImage = imageCahce[urlString] {
            self.image = cachedImage
            return
        }
        
        //check if image does not exist in cache
        
        //url for image location
        guard let url = URL(string: urlString) else {return}
        
        //fetch contents of url
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //STEP 1: handle error
            if let error = error {
                print("DEBUG: failed to load image with error \(error.localizedDescription)")
            }
            //STEP 2: image data
            guard let imageData = data else {return}
            
            //STEP 3: set image using data
            let photoImage = UIImage(data: imageData)
            
            //STEP 4: set key and value for image cache
            imageCahce[url.absoluteString] = photoImage
            
            //STEP 5: set image
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}

extension UIViewController {
    
    func presentAlertController(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func shouldPresentLoadingView(_ present: Bool, message: String? = nil){
        if present {
            let loadingView = UIView()
            loadingView.frame = self.view.frame //the view will take up whole screen
            loadingView.backgroundColor = .black
            loadingView.alpha = 0
            loadingView.tag = 1
            
            let indicator = UIActivityIndicatorView() //makes the circular 'loading' indicator
            indicator.style = .large
            indicator.center = view.center
            indicator.color = .white
            
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .white
            label.alpha = 0.87
            label.textAlignment = .center
            
            view.addSubview(loadingView)
            loadingView.addSubview(indicator)
            loadingView.addSubview(label)
            
            label.centerX(inView: view)
            label.anchor(top: indicator.bottomAnchor, paddingTop: 35)
            
            indicator.startAnimating() //makes the 'loading' animation
            
            UIView.animate(withDuration: 0.3) {
                loadingView.alpha = 0.7
            }
            
          
        } else {
            view.subviews.forEach { (subview) in
                if subview.tag == 1 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0
                    }) { (_) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
}
