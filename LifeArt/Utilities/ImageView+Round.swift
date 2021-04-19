//
//  ImageRoundedView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import Foundation
import UIKit
@IBDesignable
public class ImageRoundedView: UIImageView {

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
