//
//  VerifyNumberVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit

class VerifyNumberVC: UIViewController, OTPDelegate {
    
    
    //MARK:- outlets
    @IBOutlet weak var otpContainerView : UIView!
    
    //MARK:- varibales Declartions
    let otpStackView = OTPStackView()
    
    
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpContainerView()
        hideKeyboard()
        setStatusBar()
    }
    
    //MARK:- Functions
    func setupOtpContainerView() {
        otpContainerView.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo: otpContainerView.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpContainerView.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpContainerView.centerYAnchor).isActive = true
    }
    
    func didChangeValidity(isValid: Bool) {
        print(otpStackView.getOTP())
        
    }
    
    //MARK:- Actions
    
    @IBAction func verifyButtonAction(_ sender : UIButton){
        self.pushToController(from: .main , identifier: .CreateProfileVC)
    }
    
    
    //MARK:-APIs
    
    
    
    


}
