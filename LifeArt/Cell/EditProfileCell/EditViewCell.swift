//
//  EditViewCell.swift
//  EditProfile
//
//  Created by macbook on 4/23/21.
//

import UIKit

class EditViewCell: UITableViewCell {

    //MARK:-Outlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var changeButton : UIButton!
    
    //MARK:-Outlets
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
