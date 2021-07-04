//
//  ChatDetailCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 30/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import SDWebImage
class ChatDetailCell: UITableViewCell {

    
    @IBOutlet weak var userImage: ImageRoundedView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var message : UILabel!
    
    @IBOutlet weak var responseLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func cofigureCell(mesageData : NewMessagesModel) {
        userImage.sd_setImage(with:URL(string:mesageData.usererImage),
                              placeholderImage: UIImage(named: "placeholder.png"))
        userNameLbl.text = mesageData.username
        message.text = mesageData.user.message
        dateLbl.text = Double(mesageData.user.time).getDateStringFromUnixTime(dateStyle: .long, timeStyle: .medium)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
