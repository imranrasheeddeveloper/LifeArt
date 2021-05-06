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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.viewShadowWithoutBorder()
    }

    
    @IBAction func seeProfileAction(_ sender: UIButton) {
        
    }
    
}
