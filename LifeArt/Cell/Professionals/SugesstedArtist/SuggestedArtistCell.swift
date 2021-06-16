//
//  SuggestedArtistCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 04/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class SuggestedArtistCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dicLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.75, y: 0.75)
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.viewShadowWithoutBorder()
    }

    
    @IBAction func seeProfileAction(_ sender: UIButton) {
        
    }
    
}
