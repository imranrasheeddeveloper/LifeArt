//
//  CreateProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
class CreateProfileVC: UIViewController {
    
    @IBOutlet weak var topHeaderView : UIView!
    @IBOutlet weak var profileImage  : UIImageView!
    @IBOutlet weak var firstNameTF  : MDCOutlinedTextField!
    @IBOutlet weak var lastNameTF  : MDCOutlinedTextField!
    @IBOutlet weak var emailTF  : MDCOutlinedTextField!
    @IBOutlet weak var countryTF  : MDCOutlinedTextField!
    @IBOutlet weak var cityTF  : MDCOutlinedTextField!
    @IBOutlet weak var phoneNoTF  : MDCOutlinedTextField!
    @IBOutlet weak var websiteTF  : MDCOutlinedTextField!
    
    
    
    var password  : String!
    var firstName  : String!
    var lastName  : String!
    var email  : String!
    var country  : String!
    var city  : String!
    var phoneNo  : String!
    var website : String!
    var array : [String]!
    
    var accountType : AccountType!
    @IBOutlet weak var heightConstraint:NSLayoutConstraint!
    let maxHeaderHeight: CGFloat = 410
    let minHeaderHeight: CGFloat = 0
    var authCredentials : AuthCredentials?
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        topHeaderView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        topHeaderView.dropShadow()
        firstNameTF.text = firstName
        lastNameTF.text = lastName
        emailTF.text = email
        phoneNoTF.text = phoneNo
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleAddProfileImage))
        profileImage.addGestureRecognizer(tap)
        imagePicker.delegate = self
        setupTextFileds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK:- Helper Functions
    
    func setupTextFileds() {
        emailTF.label.text = "Email"
        firstNameTF.label.text = "First Name"
        lastNameTF.label.text = "Last Name"
        phoneNoTF.label.text = "Contact"
        countryTF.label.text = "Country"
        cityTF.label.text = "City"
        websiteTF.label.text = "Website"
        
        
        emailTF.sizeToFit()
        firstNameTF.sizeToFit()
        lastNameTF.sizeToFit()
        phoneNoTF.sizeToFit()
        countryTF.sizeToFit()
        cityTF.sizeToFit()
        websiteTF.sizeToFit()
        
        
        emailTF.containerRadius = 10
        firstNameTF.containerRadius = 10
        lastNameTF.containerRadius = 10
        phoneNoTF.containerRadius = 10
        countryTF.containerRadius = 10
        cityTF.containerRadius = 10
        websiteTF.containerRadius = 10
        
        emailTF.verticalDensity = 40
        phoneNoTF.verticalDensity = 40
        firstNameTF.verticalDensity = 40
        lastNameTF.verticalDensity = 40
        countryTF.verticalDensity = 40
        cityTF.verticalDensity = 40
        websiteTF.verticalDensity = 40
        
    }
    
    
    
    @IBAction func continueButtonAction(_ sender : UIButton){
        createAccount()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func createAccount() {
        if validation(){
            
            AppDelegate.shared.loadindIndicator(title: "Creating Account")
            let credentials =   AuthCredentials(bio: "Test", city: cityTF.text!, country: countryTF.text!, email: emailTF.text!, firstname: firstNameTF.text!, profileImage: profileImage.image!, lastname: lastNameTF.text!, password: password, phone: phoneNoTF.text!, website: websiteTF.text!)
            
            switch accountType {
            case .Model:
                AuthService.shared.registerUser(account: .Model, credentials: credentials , value :  array) { (error, ref) in
                    if error == nil{
                        
                        AppDelegate.shared.removeLoadIndIndicator()
                        DispatchQueue.main.async {
                            addLottieAnimation(string: "success", view: self.view)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            
                            self.pushToController(from: .Home , identifier: .TabBar)
                        }
                        
                    }
                    else{
                        AppDelegate.shared.removeLoadIndIndicator()
                        DispatchQueue.main.async {
                            self.showErrorAlert()
                        }
                    }
                    
                }
            case .Artist :
                AuthService.shared.registerUser(account: .Artist, credentials: credentials ,  value : array) { (error, ref) in
                    if error == nil{
                        AppDelegate.shared.removeLoadIndIndicator()
                        self.pushToController(from: .Home , identifier: .TabBar)
                    }
                    else{
                        AppDelegate.shared.removeLoadIndIndicator()
                        DispatchQueue.main.async {
                            self.showErrorAlert()
                        }
                        
                    }
                }
            default:
                break
            }
        }
        
        
    }
    func showErrorAlert() {
        let storyBoard = UIStoryboard(name: "Alerts", bundle: nil)
        let customAlert = storyBoard.instantiateViewController(withIdentifier: "ErrorAlertVC") as! ErrorAlertVC
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    func validation() -> Bool {
        if firstNameTF.text!.isEmpty {
            snackBar(str: "Please enter your firstname")
        }
        if lastNameTF.text!.isEmpty {
            snackBar(str: "Please enter your lastname")
            return false
        }
        if emailTF.text!.isEmpty {
            snackBar(str: "Please enter valid email")
            return false
        }
        if countryTF.text!.isEmpty {
            snackBar(str: "Please enter your country name")
            return false
        }
        if cityTF.text!.isEmpty {
            snackBar(str: "Please enter your city name")
            return false
        }
        if websiteTF.text!.isEmpty {
            snackBar(str: "Please enter your website")
            return false
        }
        
        return true
        
    }
    
    
}

extension CreateProfileVC : UIScrollViewDelegate {
    @objc func handleAddProfileImage() {
        present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerDelegate
extension CreateProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.originalImage] as? UIImage else {return}
        self.profileImage.image = profileImage.withRenderingMode(.alwaysOriginal)
        dismiss(animated: true, completion: nil)
    }
}
