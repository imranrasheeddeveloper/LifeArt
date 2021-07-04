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
import CoreLocation
protocol GalleryVCDelegate {
    func delete()
}


class GalleryVC: UIViewController{
    
    @IBOutlet weak var tableview :    UITableView!
    @IBOutlet weak var topSearchView: UIView!
    var count = 0
    let delegate = GalleryDelegate()
    public var postArray = [Post]()
    public var tempPostArray = [Post]()
    var locationManager:CLLocationManager!
    var refreshControl: UIRefreshControl!
    let group = DispatchGroup()
    var flag = false
    var previousKey: String = ""
    
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setStatusBar()
        showAlert()
        ConfigureViews()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableview.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStatusBar()
        hideKeyboard()
        fetchPost()
        
    }
    @objc func refresh(_ sender: Any) {
        
          fetchPost()
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
        tableview.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
    
    
    //MARK:- Actions
    @IBAction func openMessages(_ sender: UIButton) {
        _ = ChatViewController()
        self.pushToController(from: .Home, identifier: .ChatVC)
        //self.navigationController?.pushViewController(Chat, animated: true)
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
        self.pushToController(from: .Home, identifier: .NotificationVC)
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        self.pushToController(from: .Home, identifier: .MyProfileVC)
        
    }
    
    
    @IBAction func postYourArtHere(_ sender: Any) {
        self.pushToController(from: .Home, identifier: .CreatePostVC)
    }
    //MARK:-API
    
    
}

//MARK:- Post Cell delegate
extension GalleryVC : postCellDelegate{
    
    func delete(tag : Int) {
        PostService.shared.deletePost(childID: postArray[tag].key) { (delete) in
//            if delete {
//                fetchPost()
//            }
//            else{
//
//            }
        }
    }
    
    func comments(tag: Int) {
        commentsTag = postArray[tag].key
        postOwner   = postArray[tag].postData.user
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
    func report(tag: Int) {
        postTag = tag
    }
    func likePost(tag: Int) {
        PushNotificationSender.shared.sendPushNotification(to: postArray[tag].postData.user, title: "Someone Liked Your Post", body: "Liked on Your Post")
        
    }
    
    func fetchPost() {
        
        REF_Posts.child("artists").observe(.value) { [self] (snapshot) in
            
            for (i , snap) in snapshot.children.enumerated() {
                let postSnap = snap as! DataSnapshot
                let postDict = postSnap.value as! [String:AnyObject]
                tempPostArray.removeAll()
                UserService.shared.fetchArtistUser(uid: postDict["user"] as! String) { (user) in
                    PostService.shared.fetchLikesOnPost(postId: postSnap.key) { (totalLikes) in
                        PostService.shared.fetchNumberOfComments(postId: postSnap.key) { (totalComments) in
                            PostService.shared.fetchAlreadyLiked(postkey: postSnap.key) {
                                [self] (exist) in
                                if exist {
                                  flag = true
                                }
                                else{
                                  flag = false
                                }
                                    let post = Post(key: postSnap.key, postData: PostData(dictionary: postDict), userData: PostUserData(fullName: user.firstname, lastName: user.lastname, profileImage: user.image), postLikeAndCommentsData: PostLikeAndCommentsData(numberOfLikes: String(totalLikes), numberOfComments: String(totalComments), liked: flag))
                                        tempPostArray.append(post)
                                    postArray = tempPostArray
                                    DispatchQueue.main.async {
                                        self.tableview.reloadData()
                                      
                                    }
                            }
                        }
                    }
                }
            }
        }
        
    }
}



