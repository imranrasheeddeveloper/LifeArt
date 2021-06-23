//
//  LoginVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 28/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents.MDCOutlinedTextField
class LoginVC: UIViewController {

    //MARK:- outlets
    
    @IBOutlet weak var navigationBarView: UIView!
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var passwordTF: MDCOutlinedTextField!
    @IBOutlet weak var signUpLbl: UILabel!
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        self.hideKeyboard()
        navigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navigationBarView.dropShadow()
        signUpLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(signUP))
        signUpLbl.addGestureRecognizer(tap)
        setupTextFileds()
        
    
    }
    
    func setupTextFileds() {
        emailTF.label.text = "Email"
        passwordTF.label.text = "Password"
        emailTF.sizeToFit()
        passwordTF.sizeToFit()
        emailTF.containerRadius = 10
        emailTF.verticalDensity = 40
        passwordTF.containerRadius = 10
        passwordTF.verticalDensity = 40
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK:- Selector
    
    @objc func signUP(){
        self.pushToController(from: .main, identifier: .SignupVC)
    }
    
    //MARK:- Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if validation(){
            loginUser()
        }else{
            snackBar(str: "Email or Password is Missing")
            removeLottieAnimation()
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
        addLottieAnimation(string: "log", view: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
            AuthService.shared.logUserIn(email: emailTF.text!, password: passwordTF.text!) { (result, error) in
                if let error = error {
                    print("DEBUG: Error is -> \(error.localizedDescription)")
                    self.presentAlertController(withTitle: "Error", message: error.localizedDescription)
                    removeLottieAnimation()
                    return
                }
                removeLottieAnimation()
                
            
                
                self.pushToController(from: .Home, identifier: .TabBar)
            }
        
        })
            
        
    }

    
}
