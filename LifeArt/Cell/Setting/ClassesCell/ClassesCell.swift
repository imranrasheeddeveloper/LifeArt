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
         bgView.dropShadow()
         self.contentView.backgroundColor = .clear
  
         super.awakeFromNib()
        
    }
}


