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


class GalleryVC: UIViewController , postCellDelegate{
    
    @IBOutlet weak var tableview :    UITableView!
    @IBOutlet weak var topSearchView: UIView!
    
    let delegate = GalleryDelegate()
    public var postArray = [Post]()
    public var userArray = [User]()
    public var postLikeCount  = [String]()
    public var postNumberOfComments  = [String]()
    public var postLikesArray = [PostLikes]()
    let group = DispatchGroup()
    var locationManager:CLLocationManager!
    var refreshControl: UIRefreshControl!
   
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
        postLikesArray.removeAll()
        PostService.shared.fetchLikesGallery { [self] (array) in
            postLikesArray = array
            fetchFeeds()
        }
    }
    @objc func refresh(_ sender: Any) {
        postLikesArray.removeAll()
        PostService.shared.fetchLikesGallery { [self] (array) in
            postLikesArray = array
            fetchFeeds()
        }
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
        let Chat = ChatViewController()
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
    
    func fetchFeeds(){
        tableview.isHidden = true
        addLottieAnimation(string: "PostLoading", view: self.view)
        postArray.removeAll()
        userArray.removeAll()
        postLikeCount.removeAll()
        postNumberOfComments.removeAll()
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
                                    tableview.isHidden = false
                                    removeLottieAnimation()
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
    
    func delete() {
        self.fetchFeeds()
    }
    
    func comments(tag: Int) {
        print(tag)
        commentsTag = postArray[tag].key
        postOwner   = postArray[tag].postData.user
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
    func report(tag: Int) {
        postTag = tag
    }
    func likePost(tag: Int) {
        PostService.shared.fetchLikesGallery { [self] (result) in
            //for data in result {
                PostService.shared.likePost(postId: postArray[tag].key) { [self] (error, ref) -> (Void) in
                   
                   postLikesArray.append(PostLikes(postID: postArray[tag].key, data: postLikeData(userID: Auth.auth().currentUser?.uid, like: 1)))
                    
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                    
                    PushNotificationSender.shared.sendPushNotification(to: postArray[tag].postData.user, title: "Someone Liked Your Post", body: "Liked on Your Post")
               // }
//                if data.postID == postArray[tag].key
//                {
//
//                }
               // else {
//                    PostService.shared.unLikePost(postId: postArray[tag].key) { (error, ref) -> (Void) in
//                        if error != nil {
//                            print(error as Any)
//                        }
//                    }
//                }
                
                
            }
        }
        
    }
    
    
}

