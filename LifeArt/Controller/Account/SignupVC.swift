//
//  SignupVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit

class SignupVC: UIViewController , UITextFieldDelegate{
    
    //MARK:-Outlets
    
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var userType : UISegmentedControl!
    @IBOutlet weak var firstNameTF  : UITextField!
    @IBOutlet weak var lastNameTF  : UITextField!
    @IBOutlet weak var emailTF  : UITextField!
    @IBOutlet weak var passwordTF  : UITextField!
    @IBOutlet weak var phoneTF  : UITextField!
    @IBOutlet weak var whoAreYou  : UITextField!
    
    //MARK:- Variables
    var heightConstraint:NSLayoutConstraint!
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK:- variables
    
    private let imagePicker = UIImagePickerController()
    
    //MARK:- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        hideKeyboard()
        setStatusBar()
        whoAreYou.delegate = self
        loginLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(login))
        loginLbl.addGestureRecognizer(tap)
        //self.whoAreYou.inputView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- Actions
    @IBAction func signUPAction(_ sender : UIButton){
        
        if validation(){
            let accountType = userType.selectedSegmentIndex
            if #available(iOS 13.0, *) {
                let vc = storyBoard.instantiateViewController(identifier: "CreateProfileVC") as! CreateProfileVC
                vc.firstName = firstNameTF.text!
                vc.lastName = lastNameTF.text!
                vc.email = emailTF.text!
                vc.password = passwordTF.text!
                vc.phoneNo = phoneTF.text!
                if accountType == 0{
                    vc.accountType = .Model
                }
                else{
                    vc.accountType = .Artist
                }
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = storyBoard.instantiateViewController(withIdentifier: "CreateProfileVC") as! CreateProfileVC
                vc.firstNameTF.text = firstNameTF.text!
                vc.lastNameTF.text = lastNameTF.text!
                vc.emailTF.text = emailTF.text!
                vc.password = passwordTF.text!
                if accountType == 0{
                    vc.accountType = .Model
                }
                else{
                    vc.accountType = .Artist
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == whoAreYou {
            DispatchQueue.main.async { [self] in
                self.view.endEditing(true)
            }
            showSheet()
        }
    }
    
    //MARK:- Helper Functions
    func showSheet() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
    func validation() -> Bool {
        if firstNameTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "First Name is Empty")
            return false
        }
        if lastNameTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "Last Name is Empty")
            return false
        }
        if emailTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "email is Empty")
            return false
        }
        if passwordTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "password is Empty")
            return false
        }
        if phoneTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "phone is Empty")
            return false
        }
        
        return true
        
    }
    
    //MARK:- Selectors
    @objc func login(){
        self.pushToController(from: .main, identifier: .LoginVC)
    }
    
    
}
extension SignupVC:  UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
