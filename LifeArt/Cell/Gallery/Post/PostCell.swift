//
//  PostCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit
import FittedSheets

protocol postCellDelegate {
    func comments(tag : Int)
}

class PostCell: UITableViewCell {
 
    @IBOutlet weak var bgView : UIView!
    var delegate : postCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.viewShadow()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func commentsSheet(_ sender : UIButton){
        let indexPath = sender.tag
        delegate!.comments(tag: indexPath)
    }
    
}
