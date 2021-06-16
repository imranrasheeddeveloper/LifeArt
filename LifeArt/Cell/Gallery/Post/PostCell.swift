//
//  PostCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//

import UIKit
import FittedSheets
import SkeletonView
import ContextMenu

protocol postCellDelegate {
    func comments(tag : Int)
    func report(tag : Int)
    func likePost(tag : Int)
}

class PostCell: UITableViewCell{
 
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var bgView : UIView!
    @IBOutlet weak var postProfileImage: UIImageView!
    @IBOutlet weak var postUserNameLbl  : UILabel!
    @IBOutlet weak var postTimeLbl : UILabel!
    @IBOutlet weak var postCountryLbl : UILabel!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var artImaeView: UIImageView!
    @IBOutlet weak var discriptionLbl: UILabel!
    @IBOutlet weak var followedDate: UILabel!
    @IBOutlet weak var viewAllcomments: UIButton!
    var delegate : postCellDelegate!
    @IBOutlet weak var totalCommentsLbl: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var reportBtn: UIButton!
    
    static let  CellIndentifier = "PostCell"
    var menuOpen : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.viewShadow()
//        postProfileImage.showSkeleton()
//        postUserNameLbl.showSkeleton()
      
        
        
    }
    
    
    
    func configureCell(post : Post , user : User , likeCount :  String? , totalComments : String? , tag : Int) {

        artImaeView.sd_setImage(with:URL(string:post.postData.image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
        discriptionLbl.text = post.postData.desc
        postUserNameLbl.text = "\(user.firstname) \(user.lastname)"
        postTimeLbl.text = post.postData.time
        followedDate.text = "Followed on \(post.postData.time)"
        postTimeLbl.text = post.postData.date
        postProfileImage.sd_setImage(with:URL(string:user.image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
        postCountryLbl.text = user.country
        likesLbl.text =  "\(likeCount ?? "0") Likes"
        viewAllcomments.tag = tag
        likeButton.tag = tag
        viewAllcomments.setTitle("View all \(totalComments ?? "0") Comments", for: .normal)
        totalCommentsLbl.text = "\(totalComments ?? "0") Comments"
        
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
        delegate!.report(tag: sender.tag)        
        ContextMenu.shared.show(
            sourceViewController: (self.window?.rootViewController)!,
            viewController: MenuViewController(),
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    backgroundColor: .white
                ),
                menuStyle: .minimal,
                hapticsStyle: .medium
            ),
            sourceView: reportBtn,
            delegate: self
        )
    }
    
    @IBAction func reportThePost(_ sender: UIButton) {
        delegate.report(tag: sender.tag)
        
        
    }
}
extension PostCell: ContextMenuDelegate{
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool) {
        print("will dismiss")
    }

    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool) {
        
        
        
        switch menuClick {
        case .editPost:
            break
        case .deletePost:
            
            break
            
        case .reportPost:
            PostService.shared.reportPost(postUserId: arrayOfPosts[postTag!].postData.user) { (error, data) -> (Void) in
                self.window?.rootViewController!.showToast(message: "Post Reported", seconds: 1.0)
                    }
           
            break
        default:
            return
        }
        
        
    }
    
}
