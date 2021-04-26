//
//  CommentsCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {
    
    @IBOutlet weak var bubble : UIView!
    @IBOutlet weak var commentText : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}


@IBDesignable
class SpeechBubble: UIView {

@IBInspectable var lineWidth: CGFloat = 4 { didSet { setNeedsDisplay() } }
@IBInspectable var cornerRadius: CGFloat = 8 { didSet { setNeedsDisplay() } }

@IBInspectable var strokeColor: UIColor = .red { didSet { setNeedsDisplay() } }
@IBInspectable var fillColor: UIColor = .gray { didSet { setNeedsDisplay() } }

@IBInspectable var peakWidth: CGFloat  = 10 { didSet { setNeedsDisplay() } }
@IBInspectable var peakHeight: CGFloat = 10 { didSet { setNeedsDisplay() } }
@IBInspectable var peakOffset: CGFloat = 0 { didSet { setNeedsDisplay() } }

override func draw(_ rectangle: CGRect) {
    
    //Add a bounding area so we can fit the peak in the view
    let rect = bounds.insetBy(dx: peakHeight, dy: peakHeight)
    
    let centerX = rect.width / 2
    //let centerY = rect.height / 2
    var h: CGFloat = 0
    
    //create the path
    let path = UIBezierPath()
    path.lineWidth = lineWidth
    
    // Start of bubble (Top Left)
    path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
    path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
                      controlPoint: CGPoint(x: rect.minX, y: rect.minY))
    
    //Add the peak
    h = peakHeight * sqrt(3.0) / 2

    let x = rect.origin.x + centerX
    let y = rect.origin.y
    path.addLine(to: CGPoint(x: (x + peakOffset) - peakWidth, y: y))
    path.addLine(to: CGPoint(x: (x + peakOffset), y: y - h))
    path.addLine(to: CGPoint(x: (x + peakOffset) + peakWidth, y: y))
    
    // Top Right
    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
    path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius),
                      controlPoint: CGPoint(x: rect.maxX, y: rect.minY))
    
    // Bottom Right
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
    path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY),
                      controlPoint: CGPoint(x: rect.maxX, y: rect.maxY))
    //Bottom Left
    path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
    path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius), controlPoint: CGPoint(x: rect.minX, y: rect.maxY))
    // Back to start
    path.addLine(to: CGPoint(x: rect.origin.x, y: rect.minY + cornerRadius))
    
    //set and draw stroke color
    strokeColor.setStroke()
    path.stroke()
    
    //set and draw fill color
    fillColor.setFill()
    path.fill()
    
  }
}
