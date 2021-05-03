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
    var pageIndex: Int = 0
    public var postArray = [Post]()
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        showAlert()
        ConfigureViews()
        PostService.shared.fetchPost { [self] (post) in
            self.postArray = post
            dump(postArray)
            for
            UserService.shared.fetchUser(uid: post, completion: <#T##(User) -> Void#>)
            DispatchQueue.main.async {
                dump(postArray)
                self.tableview.reloadData()
            }
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool){
        //tableview.showSkeleton(usingColor: .black, transition: .crossDissolve(0.25))
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
    
}
//MARK:- Post Cell delegate
extension GalleryVC {
    func comments(tag: Int) {
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }
}


