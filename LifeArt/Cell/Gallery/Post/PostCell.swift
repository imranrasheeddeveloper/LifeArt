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


public protocol SkeletonTableViewDataSource: UITableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
}

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
    var postLikesArray = [PostLikes]()
    static let  CellIndentifier = "PostCell"
    static let  CellIndentifier2 = PostCell()
    var menuOpen : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.viewShadow()
        
    }
    
    
    
    func configureCell(post : Post , user : User , likeCount :  String? , totalComments : String? , tag : Int) {
        

        
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
