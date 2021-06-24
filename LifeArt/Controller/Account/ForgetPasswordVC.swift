//
//  ForgetPasswordVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 28/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
class ForgetPasswordVC: UIViewController {

    
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var navigationBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        self.hideKeyboard()
        navigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navigationBarView.dropShadow()
        setupTextFileds()
    
    }
    
    func setupTextFileds() {
        emailTF.label.text = "Email"
        emailTF.sizeToFit()
        emailTF.containerRadius = 10
        emailTF.verticalDensity = 40
    }
    
    @IBAction func recoverButtonPressed(_ sender: UIButton) {
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    

}
