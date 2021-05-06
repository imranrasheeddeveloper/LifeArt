//
//  GalleryVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit
import FittedSheets
import SkeletonView
import Firebase
class GalleryVC: UIViewController , postCellDelegate{
    
    
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var topSearchView: UIView!
    
    let delegate = GalleryDelegate()
    public var postArray = [Post]()
    public var userArray = [User]()
    var refreshControl: UIRefreshControl!
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        showAlert()
        ConfigureViews()
        fetchFeeds()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }


@objc func refresh(_ sender: Any) {
    self.postArray.removeAll()
    fetchFeeds()
    
}
//MARK:- Helper functions
func showAlert() {
    let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
    customAlert.providesPresentationContextTransitionStyle = true
    customAlert.definesPresentationContext = true
    customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    //customAlert.delegate = self
    self.present(customAlert, animated: true, completion: nil)
}

func ConfigureViews() {
    tableview.reloadData()
    tableview.dataSource = self
    tableview.delegate = delegate
    hideKeyboard()
    setStatusBar()
    regiesterNibs()
    tableview.separatorStyle = .none
    self.sheetViewController?.allowGestureThroughOverlay = true
    self.sheetViewController?.handleScrollView(tableview)
    topSearchView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
    topSearchView.dropShadow()
}
func regiesterNibs() {
    tableview.register(UINib(nibName: "GalleryHeaderCell", bundle: nil), forCellReuseIdentifier: "GalleryHeaderCell")
    tableview.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
}

    //MARK:-API

func fetchFeeds(){
    
    PostService.shared.fetchPost { [self] (post) in
    self.postArray = post
    for post in postArray{
        UserService.shared.fetchUser(uid: post.user ) { (user) in
            self.userArray.append(user)
            DispatchQueue.main.async {
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
}


}

//MARK:- Post Cell delegate
extension GalleryVC {
    func comments(tag: Int) {
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
}


