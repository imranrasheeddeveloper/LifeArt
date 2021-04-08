//
//  PostCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit

class PostCell: UITableViewCell {
 
    @IBOutlet weak var bgView : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.viewShadow()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
