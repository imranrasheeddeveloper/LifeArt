//
//  CreateProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class CreateProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
    }
    
    @IBAction func continueButtonAction(_ sender : UIButton){
        self.pushToController(from: .Home , identifier: .TabBar)
    }

}
