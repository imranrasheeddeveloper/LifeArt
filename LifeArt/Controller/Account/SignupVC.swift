//
//  SignupVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
protocol whoAreYouDelegate {
    func whoAreYouData(categories : [String])
}

class SignupVC: UIViewController , UITextFieldDelegate, whoAreYouDelegate{
    
    //MARK:-Outlets
    
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var userType : UISegmentedControl!
    @IBOutlet weak var firstNameTF  : MDCOutlinedTextField!
    @IBOutlet weak var lastNameTF  : MDCOutlinedTextField!
    @IBOutlet weak var emailTF  : MDCOutlinedTextField!
    @IBOutlet weak var passwordTF  : MDCOutlinedTextField!
    @IBOutlet weak var phoneTF  : MDCOutlinedTextField!
    @IBOutlet weak var whoAreYou  : MDCOutlinedTextField!
    
    
    //MARK:- Variables
    var heightConstraint:NSLayoutConstraint!
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var selectedArray : [String] = []
    //MARK:- variables
    
    private let imagePicker = UIImagePickerController()
    
    //MARK:- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        hideKeyboard()
        setStatusBar()
        setupTextFileds()
        whoAreYou.delegate = self
        loginLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(login))
        loginLbl.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    
    //MARK:- Helper Function
    
    func setupTextFileds() {
        emailTF.label.text = "Email"
        passwordTF.label.text = "Password"
        firstNameTF.label.text = "First Name"
        lastNameTF.label.text = "Last Name"
        phoneTF.label.text = "Contact"
        whoAreYou.label.text = "Who you Are?"
        
        
        emailTF.sizeToFit()
        passwordTF.sizeToFit()
        firstNameTF.sizeToFit()
        lastNameTF.sizeToFit()
        phoneTF.sizeToFit()
        whoAreYou.sizeToFit()
        
        
        emailTF.containerRadius = 10
        passwordTF.containerRadius = 10
        firstNameTF.containerRadius = 10
        lastNameTF.containerRadius = 10
        phoneTF.containerRadius = 10
        whoAreYou.containerRadius = 10
        
        
        emailTF.verticalDensity = 40
        passwordTF.verticalDensity = 40
        phoneTF.verticalDensity = 40
        firstNameTF.verticalDensity = 40
        lastNameTF.verticalDensity = 40
        whoAreYou.verticalDensity = 40
        
        
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
                vc.array = selectedArray
                dump(selectedArray)
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
                vc.array = selectedArray
                dump(selectedArray)
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
        slideVC.delegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
    func validation() -> Bool {
        if firstNameTF.text!.isEmpty {
          snackBar(str: "Please enter your firstname")
            return false
        }
        if lastNameTF.text!.isEmpty {
            snackBar(str: "Please enter your lastname")
            return false
        }
        if !(emailTF.text!.isValidEmail()){
            snackBar(str: "Please enter valid email")
            return false
        }
        
        if passwordTF.text!.isEmpty {
            snackBar(str: "Please enter your password")
            return false
        }
        if phoneTF.text!.isEmpty {
            snackBar(str: "Please enter your phone")
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
    func whoAreYouData(categories : [String] ) {
        categories.forEach({
            guard let whoAreYou = whoAreYou.text else {return}
            let whoAreYouString  = "\(whoAreYou),\($0)"
            self.whoAreYou.text =  String(whoAreYouString.dropFirst())
        })
        selectedArray = categories
        selectedArray.removeAll()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        whoAreYou.text = ""
       return PresentationController(presentedViewController: presented, presenting: presenting)
       
    }
  
    
}

