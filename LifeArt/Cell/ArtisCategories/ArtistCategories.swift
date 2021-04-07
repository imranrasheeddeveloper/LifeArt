//
//  ArtistCategories.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class ArtistCategories: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var categoriesLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = .white
        //bgView.borderWidth = 0.5
    }
    
    override var isSelected: Bool {
            didSet {
                if self.isSelected {
                    bgView.backgroundColor = UIColor(named: "colorAccent")
                    categoriesLbl.textColor = .white
                }
                else {
                    bgView.backgroundColor = .white
                    categoriesLbl.textColor = .black
                }
            }
        }

}
