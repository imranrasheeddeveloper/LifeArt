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

protocol GalleryVCDelegate {
    func reportThePost()
}


class GalleryVC: UIViewController , postCellDelegate{
    
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var topSearchView: UIView!
    
    let delegate = GalleryDelegate()
    public var postArray = [Post]()
    public var userArray = [User]()
    public var postLikeCount  = [String]()
    public var postNumberOfComments  = [String]()
    let group = DispatchGroup()
//    let serialQueue = DispatchQueue(label: "serialQueueWork" )
//    let semaphore = DispatchSemaphore(value: 1)
    var refreshControl: UIRefreshControl!
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        showAlert()
        ConfigureViews()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFeeds()
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
    //MARK:- Actions
    @IBAction func openMessages(_ sender: UIButton) {
        let message = NewMessagesVC()
        self.navigationController?.pushViewController(message, animated: true)
    }
    
    //MARK:-API
    
    func fetchFeeds(){
        PostService.shared.fetchPost { [self] (post) in
            self.postArray = post
            arrayOfPosts = post
            for post in postArray{
                UserService.shared.fetchUser(uid: post.postData.user) { (user) in
                    PostService.shared.fetchLikesOnPost(postId: post.key) { (count) in
                        PostService.shared.fetchNumberOfComments(postId: post.key) { (commentsCount) in
                            self.userArray.append(user)
                            postLikeCount.append(String(count))
                            postNumberOfComments.append(String(commentsCount))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                self.tableview.reloadData()
                                self.refreshControl.endRefreshing()
                            })
                        }
                       
                    }
                }
            }
        }
    }
    
}

//MARK:- Post Cell delegate
extension GalleryVC {
    func comments(tag: Int) {
        print(tag)
        commentsTag = postArray[tag].key
        postOwner   = postArray[tag].postData.user
        print(postOwner)
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
    func report(tag: Int) {
    
        postTag = tag
        
      print(tag)
        
    }
    func likePost(tag: Int) {
        PostService.shared.likePost(postId: postArray[tag].key) { (error, ref) -> (Void) in
            DispatchQueue.main.async { [self] in
               fetchFeeds()
            }
        }
    }
    
    
}


