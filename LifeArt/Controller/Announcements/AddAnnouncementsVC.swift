//
//  AddAnnouncementsVC.swift
//  LifeArt
//
//  Created by Sohaib Ahmed Khan on 17/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class AddAnnouncementsVC: UIViewController {
    //MARK:_ OUTLETS
    @IBOutlet weak var headerView: UIView!

    //MARK:-LiFECYCles
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        setStatusBar()
        hideKeyboard()
        self.navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func makeAnnouncementBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
