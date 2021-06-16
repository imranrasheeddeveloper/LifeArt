//
//  MyProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 20/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import ContextMenu
class MyProfileVC: UIViewController, UICollectionViewDelegate, UIViewControllerTransitioningDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var followAction: UIButton!
    @IBOutlet weak var heightConstrains: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topConstrainsOfHeader: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    //MARK:- DataHolders
    public var postArray = [Post]()
    public var imageArray = [String]()
    public var postLikeCount  : [String]?
    public var postNumberOfComments  : [String]?
    
    //MARK:- Scrollview Helper
    var selectedIndex = 0
    let maxHeaderHeight: CGFloat = 320
    let minHeaderHeight: CGFloat = 0
    var previousScrollOffset: CGFloat = 0
   
    //MARK:-Objects
    public var user: User?
    let photosDataSource = PhotosDataSource()
    let photoDelegate = PhotosDelegate()
    
    
    //MARK:- Creating Views
    private let collectionViewLayout: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        return cv
    }()
    
    
    private let tableviewLayout : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white
        table.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        table.separatorStyle = .none
        return table
    }()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        setupViews()

    }
    override func viewWillAppear(_ animated: Bool) {
        setStatusBar()
        hideKeyboard()
        fetchUser()
        
        self.tableviewLayout.separatorStyle = .none
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK:- Setup Views
    func setupConstrainsofCollectionView() {
        self.collectionViewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    func setupConstrainsofTableView() {
        self.tableviewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func setupViews() {
        if selectedIndex == 0{
            self.contentView.addSubview(tableviewLayout)
            tableviewLayout.delegate = self
            tableviewLayout.dataSource = self
            setupConstrainsofTableView()
        }
        else{
            setupConstrainsofCollectionView()
            self.contentView.addSubview(collectionViewLayout)
            collectionViewLayout.dataSource = photosDataSource
            collectionViewLayout.delegate = self
        }
    }
    
    
    //MARK:- Api Calling
//    func fetchFeeds(){
//        PostService.shared.fetchPost { [self] (post) in
//        self.postArray = post
//        for post in postArray{
//            UserService.shared.fetchUser(uid: post.postData.user ) { (user) in
//                self.userArray.append(user)
//                self.imageArray.append(post.postData.image)
//                DispatchQueue.main.async {
//                    self.tableviewLayout.reloadData()
//                }
//            }
//        }
//    }
//  }
    func fetchFeeds(){
        guard let uid = Auth.auth().currentUser?.uid else { return }

        UserService.shared.checkArtistExist(uid: uid) { (result) in
            
            if result{
                PostService.shared.fetchPost { [self] (post) in
                    let postData = post.filter({$0.postData.user == uid})
                    self.postArray = postData
                    for post in postArray{
                                PostService.shared.fetchLikesOnPost(postId: post.key) { (count) in
                                    PostService.shared.fetchNumberOfComments(postId: post.key) { (commentsCount) in
                                        postLikeCount?.append(String(count))
                                        postNumberOfComments?.append(String(commentsCount))
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                            self.tableviewLayout.reloadData()
                                        })
                                    }
                                   
                                }
                    }
                }
            }
        else{
            PostService.shared.fetchPostOfModel { [self] (post) in
                let postData = post.filter({$0.postData.user == uid})
                self.postArray = postData
                for post in postArray{
                            PostService.shared.fetchLikesOnPost(postId: post.key) { (count) in
                                PostService.shared.fetchNumberOfComments(postId: post.key) { (commentsCount) in
                                   print(count)
                                    print(commentsCount)
                                    postLikeCount?.append(String(count))
                                    postNumberOfComments?.append(String(commentsCount))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                        self.tableviewLayout.reloadData()
                                    })
                                }
                               
                            }
                }
            }
        }
       
    }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { [self] (user) in
            self.user = user
            if let firstName = self.user?.firstname {
                if let lastName = self.user?.lastname{
                    if let bio = self.user?.bio {
                        if let image = self.user?.image{
                            fullName.text = "\(firstName) \(lastName)"
                            userName.text = "@\(firstName)"
                            bioLbl.text = bio
                            profileImage.sd_setImage(with:URL(string: image),
                                                     placeholderImage: UIImage(named: "placeholder.png"))
                        }
                    }
                }
            }
            fetchFeeds()
            
            
        }
    }
    
    //MARK:- Acctions
    @IBAction func popViewController(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func followAction(_ sender: UIButton) {
      
        let storyBoard  = UIStoryboard(name: "Home", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc =  storyBoard.instantiateViewController(identifier: "EditProfile") as! EditProfile
           // vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc =  storyBoard.instantiateViewController(withIdentifier: "EditProfile") as! EditProfile
           // vc.user = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    
    
    @IBAction func seeMoreInfo(sender : UIButton){
        GlobaluserID = Auth.auth().currentUser!.uid
        presenttSheet(tag: 0, view: self.view, controller: self, Identifier: .PesonalDetailVC, storyBoard: .Settings)
    }
    
    @IBAction func ValueChanged(_ sender: SWSegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            selectedIndex = 0
            self.collectionViewLayout.removeFromSuperview()
            self.contentView.addSubview(tableviewLayout)
            setupConstrainsofTableView()
            tableviewLayout.delegate = self
            tableviewLayout.dataSource = self
            setupConstrainsofTableView()
            fetchFeeds()
        }
        else if sender.selectedSegmentIndex == 1 {
            selectedIndex = 1
            tableviewLayout.removeFromSuperview()
            self.contentView.addSubview(collectionViewLayout)
            setupConstrainsofCollectionView()
            collectionViewLayout.dataSource = photosDataSource
            collectionViewLayout.delegate = self
            photosDataSource.arrayOfImage = imageArray
            DispatchQueue.main.async {
                self.collectionViewLayout.reloadData()
            }
        }
    }
    
    @IBAction func openBottomSheet(_ sender : UIButton){
        self.pushToRoot(from: .Settings, identifier: .SettingsVC)
    
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        MenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    @IBAction func editProfileAction(_ sender: UIButton) {
        
    }
    
    @IBAction func menuDropDownAction(_ sender: UIButton) {
       // if let cell = sender.superview as? PostCell{}
        
       
        
    }
 
}


extension MyProfileVC {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.heightConstrains.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    func setScrollPosition() {
        if selectedIndex == 0{
            self.tableviewLayout.contentOffset = CGPoint(x:0, y: 0)
            
        }
       else if selectedIndex == 1{
        self.collectionViewLayout.contentOffset = CGPoint(x:0, y: 0)
        }
    }
}
extension MyProfileVC : UICollectionViewDelegateFlowLayout{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = heightConstrains.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, heightConstrains.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, heightConstrains.constant + abs(scrollDiff))
               // headerView.fadeIn()
            }
            if newHeight != heightConstrains.constant {
                heightConstrains.constant = newHeight

                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
//            if heightConstrains.constant <= 20 {
//                headerView.fadeOut()
//            }
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
}

//MARK:- TabelView delegate
extension MyProfileVC :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}

//MARK : - postCellDelegate
extension MyProfileVC : postCellDelegate
{
    
    
    func report(tag: Int) {
        
    }
    
    func likePost(tag: Int) {
        PostService.shared.likePost(postId: postArray[tag].key) { (error, ref) -> (Void) in
            DispatchQueue.main.async { [self] in
               fetchFeeds()
            }
        }
    }
    
    func comments(tag: Int) {
        commentsTag = postArray[tag].key
        postOwner   = postArray[tag].postData.user
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
    
}



