//
//  SignupVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit

protocol whoAreYouDelegate {
    func whoAreYouData(categories : [String])
}

class SignupVC: UIViewController , UITextFieldDelegate, whoAreYouDelegate{
    
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
    var selectedArray : [String] = []
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
//        selectData.forEach({
//            vc.whoAreYou.text = $0
//        })
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
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        whoAreYou.text = ""
       return PresentationController(presentedViewController: presented, presenting: presenting)
       
    }
  
    
}

