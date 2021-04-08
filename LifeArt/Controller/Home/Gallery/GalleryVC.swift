//
//  GalleryVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class GalleryVC: UIViewController {

    
    @IBOutlet weak var tableview : UITableView!
    let dataSource = GalleryDataSource()
    let delegate = GalleryDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        showAlert()
        hideKeyboard()
        setStatusBar()
        regiesterNibs()
        tableview.dataSource = dataSource
        tableview.delegate = delegate
        tableview.separatorStyle = .none
        
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
