//
//  CreateProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class CreateProfileVC: UIViewController {
    @IBOutlet weak var topHeaderView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
       // topHeaderView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        //topHeaderView.dropShadow()
        
    }
    
    @IBAction func continueButtonAction(_ sender : UIButton){
        self.pushToController(from: .Home , identifier: .TabBar)
    }

}
