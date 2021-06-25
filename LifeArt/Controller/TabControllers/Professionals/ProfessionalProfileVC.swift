//
//  ProfessionalProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 14/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import FittedSheets

class ProfessionalProfileVC: UIViewController, UICollectionViewDelegate, UITableViewDelegate {
    
    var user : User?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var followAction: UIButton!
    @IBOutlet weak var heightConstrains: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileimageView: ImageRoundedView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    
    
    public var postArray = [Post]()
    public var userArray = [User]()
    public var imageArray = [String]()
    public var postLikeCount  = [String]()
    public var postNumberOfComments  = [String]()
    var selectedIndex = 0
    let photosDataSource = PhotosDataSource()
    let photoDelegate = PhotosDelegate()
    let maxHeaderHeight: CGFloat = 350
    let minHeaderHeight: CGFloat = 0
    var previousScrollOffset: CGFloat = 0
    
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
        //table.register(UINib(nibName: "ProfilePostCell", bundle: nil), forCellReuseIdentifier: "ProfilePostCell")
        table.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        setStatusBar()
        hideKeyboard()
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
    
        ApiCalling()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        PostService.shared.fetchLikes {
        }
        
    }
    
    
    func setupConstrainsofCollectionView() {
        self.collectionViewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    func setupConstrainsofTableView() {
        self.tableviewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    
    @IBAction func popViewController(_ sender : UIButton){
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func followAction(_ sender: UIButton) {
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
            tableviewLayout.separatorStyle = .none
            fetchFeeds()
        }
        else if sender.selectedSegmentIndex == 1 {
            selectedIndex = 1
            tableviewLayout.removeFromSuperview()
            self.contentView.addSubview(collectionViewLayout)
            setupConstrainsofCollectionView()
            collectionViewLayout.dataSource = photosDataSource
            collectionViewLayout.delegate = self
            DispatchQueue.main.async {
                self.collectionViewLayout.reloadData()
            }
        }
    }
    
    @IBAction func seeMoreInfo(sender : UIButton){
        presenttSheet(tag: 0, view: self.view, controller: self, Identifier: .PesonalDetailVC, storyBoard: .Settings)
    }
    
    func ApiCalling() {
        UserService.shared.checkArtistExist(uid: GlobaluserID) { (result) in
            if result{
                UserService.shared.fetchArtistUser(uid: GlobaluserID) { (user) in
                    self.profileimageView.sd_setImage(with:URL(string: user.image),
                                                      placeholderImage: UIImage(named: "placeholder.png"))
                    self.bioLbl.text = user.bio
                    self.fullName.text = "\(user.firstname) \(user.lastname)"
                }
            }
            else{
                UserService.shared.fetchModelsUser(uid: GlobaluserID) { (user) in
                    self.profileimageView.sd_setImage(with:URL(string: user.image),
                                                      placeholderImage: UIImage(named: "placeholder.png"))
                    self.bioLbl.text = user.bio
                    self.fullName.text = "\(user.firstname) \(user.lastname)"
                }
            }
        }
    }
    
    func fetchFeeds(){
        PostService.shared.fetchPost { [self] (post) in
            self.postArray = post
            for post in postArray{
                UserService.shared.fetchUser(uid: post.postData.user) { (user) in
                    PostService.shared.fetchLikesOnPost(postId: post.key) { (count) in
                        PostService.shared.fetchNumberOfComments(postId: post.key) { (commentsCount) in
                            self.userArray.append(user)
                            postLikeCount.append(String(count))
                            postNumberOfComments.append(String(commentsCount))
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


extension ProfessionalProfileVC {
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
extension ProfessionalProfileVC : UICollectionViewDelegateFlowLayout{
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
        
        let noOfCellsInRow = 2
        
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
extension ProfessionalProfileVC : postCellDelegate{
    func delete() {
        fetchFeeds()
    }
    
   
    func report(tag: Int) {
        //
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

