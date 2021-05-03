//
//  LoginVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 28/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpLbl: UILabel!
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        self.hideKeyboard()
        navigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navigationBarView.dropShadow()
    
    }
    
    //MARK:- Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        AppDelegate.shared.loadindIndicator(title: "Loging")
        if validation(){
            loginUser()
        }else{
            self.presentAlertController(withTitle: "Error", message: "Email or Password is Missing")
            AppDelegate.shared.removeLoadIndIndicator()
        }
    }
    @IBAction func backButtonPresed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
        self.pushToController(from: .main, identifier: .ForgetPasswordVC)
    }
    
    //MARK:- Validator
    func validation() -> Bool{
        if !emailTF.text!.isEmpty{
            if !passwordTF.text!.isEmpty{
               return true
            }
        }
    return false
    }
    //MARK:- API Calling
    func loginUser() {
        AuthService.shared.logUserIn(email: emailTF.text!, password: passwordTF.text!) { (result, error) in
            if let error = error {
                print("DEBUG: Error is -> \(error.localizedDescription)")
                self.presentAlertController(withTitle: "Error", message: error.localizedDescription)
                AppDelegate.shared.removeLoadIndIndicator()
                return
            }
            AppDelegate.shared.removeLoadIndIndicator()
            self.pushToController(from: .Home, identifier: .TabBar)
        }
    }
}
