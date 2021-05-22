//
//  PostCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit
import FittedSheets
import SkeletonView
protocol postCellDelegate {
    func comments(tag : Int)
    func report(tag : Int)
    func likePost(tag : Int)
}

class PostCell: UITableViewCell {
 
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var postProfileImage: UIImageView!
    @IBOutlet weak var postUserNameLbl  : UILabel!
    @IBOutlet weak var postTimeLbl : UILabel!
    @IBOutlet weak var postCountryLbl : UILabel!
    @IBOutlet weak var likesCommentsShare: UILabel!
    @IBOutlet weak var artImaeView: UIImageView!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var followedDate: UILabel!
    @IBOutlet weak var viewAllcomments: UIButton!
    var delegate : postCellDelegate!
    static let  CellIndentifier = "PostCell"
    var menuOpen : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.viewShadow()
//        postProfileImage.showSkeleton()
//        postUserNameLbl.showSkeleton()
      
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func commentsSheet(_ sender : UIButton){

    }
    @IBAction func viewAllComents(_ sender: UIButton) {
        let indexPath = sender.tag
        delegate!.comments(tag: indexPath)
    }
    @IBAction func like(_ sender: UIButton) {
        delegate!.likePost(tag: sender.tag)
    }
    @IBAction func reportButton(_ sender: UIButton) {
        //delegate!.report(tag: sender.tag)
        if menuOpen{
            menuOpen = false
            menuView.fadeIn()
        }
        else{
            menuOpen = true
            menuView.fadeOut()
        }
    }
    
    @IBAction func reportThePost(_ sender: UIButton) {
        delegate.report(tag: sender.tag)
        
        
    }
}
