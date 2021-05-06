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
    
    var heightConstraint:NSLayoutConstraint!
    
    
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- Actions
    @IBAction func signUPAction(_ sender : UIButton){
      
        guard let firstName = firstNameTF.text else {
            self.presentAlert(withTitle: "Error", message: "First Name is Empty")
            return}
        guard let lastName = lastNameTF.text else {
            self.presentAlert(withTitle: "Error", message: "Last Name is Empty")
            return}
        guard let email = emailTF.text else {
            self.presentAlert(withTitle: "Error", message: "email is Empty")
            return }
        guard let password = passwordTF.text else {
            self.presentAlert(withTitle: "Error", message: "password is Empty")
            return }
        guard let phone = phoneTF.text else {return}
        let accountType = userType.selectedSegmentIndex
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let vc = storyBoard.instantiateViewController(identifier: "CreateProfileVC") as! CreateProfileVC
            vc.firstName = firstName
            vc.lastName = lastName
            vc.email = email
            vc.password = password
            vc.phoneNo = phone
            if accountType == 0{
                vc.accountType = .artist
            }
            else{
                vc.accountType = .moodels
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
           let vc = storyBoard.instantiateViewController(withIdentifier: "CreateProfileVC") as! CreateProfileVC
            vc.firstNameTF.text = firstName
            vc.lastNameTF.text = lastName
            vc.emailTF.text = email
            vc.password = password
            if accountType == 0{
                vc.accountType = .moodels
            }
            else{
                vc.accountType = .artist
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
        
    }
    @IBAction func whoAreYou(_ sender: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == whoAreYou {
                self.view.endEditing(true)
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
