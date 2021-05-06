//
//  SuggestedCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit

class SuggestedCell: UICollectionViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundView.viewShadowWithoutBorder()
    }
    @IBAction func followButtonAction(_ sender: UIButton) {
    }
    @IBAction func crossButtonAction(_ sender: UIButton) {
    }
    
}
