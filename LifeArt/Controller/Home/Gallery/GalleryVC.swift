//
//  GalleryVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit
import FittedSheets

class GalleryVC: UIViewController , postCellDelegate{
    func comments(tag: Int) {
        presenttSheet(tag: tag, view: self.view, controller: self, Identifier: .CommentsVC, storyBoard: .Home)
    }

    
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var topSearchView: UIView!
    let delegate = GalleryDelegate()
    let post = PostCell()
    var pageIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        showAlert()
        hideKeyboard()
        setStatusBar()
        regiesterNibs()
        tableview.dataSource = self
        tableview.delegate = delegate
        tableview.separatorStyle = .none
        self.sheetViewController?.allowGestureThroughOverlay = true
        self.sheetViewController?.handleScrollView(tableview)
        topSearchView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        topSearchView.dropShadow()
     
        
    
    }


    //MARK:- functions
    
    func showAlert() {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func regiesterNibs() {
        tableview.register(UINib(nibName: "GalleryHeaderCell", bundle: nil), forCellReuseIdentifier: "GalleryHeaderCell")
        tableview.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
}


