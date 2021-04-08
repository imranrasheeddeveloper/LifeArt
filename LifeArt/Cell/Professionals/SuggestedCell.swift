//
//  SuggestedCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit

class SuggestedCell: UICollectionViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundView.viewShadowWithoutBorder()
    }

}
