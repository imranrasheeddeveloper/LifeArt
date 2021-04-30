//
//  LoginVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 28/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        self.hideKeyboard()
        navigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navigationBarView.dropShadow()
      
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    @IBAction func backButtonPresed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        self.pushToController(from: .main, identifier: .ForgetPasswordVC)
    }
}
