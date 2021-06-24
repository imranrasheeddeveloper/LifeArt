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
    @IBOutlet weak var insituteName: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
  //  @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var clockView: UIView!
   // @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var salaryLbl: UILabel!
    @IBOutlet weak var titleOfType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
          discriptionView.dropShadow()
//        typeView.dropShadow()
       clockView.dropShadow()
//amountView.dropShadow()
          secondView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
