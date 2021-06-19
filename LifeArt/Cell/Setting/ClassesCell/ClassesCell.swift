//
//  ClassesCell.swift
//  LifeArtCopy
//
//  Created by macbook on 4/26/21.
//

import UIKit

class ClassesCell: UITableViewCell {
    
    //MArk:-Outlets
    
   
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameOfInstitueLbl: UILabel!
    @IBOutlet weak var addressOfInstituteLbl: UILabel!
    @IBOutlet weak var nameOfDirectorLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    

    //MArk:-Cell Functions
    override func awakeFromNib() {
         //bgView.dropShadow2()
       // self.contentView.backgroundColor = .clear
  
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue // the color applied to the shadowLayer, rather than the view's backgroundColor
     
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
          
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor

            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

    
}


