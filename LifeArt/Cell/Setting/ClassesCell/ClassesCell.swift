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
    @IBOutlet weak var bgView : UIView!
    
    //MArk:-Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.dropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
