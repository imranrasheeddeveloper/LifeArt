//
//  AnnouncmentsCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class AnnouncmentsCell: UITableViewCell {

    @IBOutlet weak var discriptionView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var amountView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        discriptionView.dropShadow()
        typeView.dropShadow()
        clockView.dropShadow()
        amountView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
