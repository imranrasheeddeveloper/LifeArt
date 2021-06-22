//
//  CreateProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class CreateProfileVC: UIViewController {
    
    @IBOutlet weak var topHeaderView : UIView!
    @IBOutlet weak var profileImage  : UIImageView!
    @IBOutlet weak var firstNameTF  : UITextField!
    @IBOutlet weak var lastNameTF  : UITextField!
    @IBOutlet weak var emailTF  : UITextField!
    @IBOutlet weak var countryTF  : UITextField!
    @IBOutlet weak var cityTF  : UITextField!
    @IBOutlet weak var phoneNoTF  : UITextField!
    @IBOutlet weak var websiteTF  : UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
            
            let credentials =   AuthCredentials(bio: "Test", city: cityTF.text!, country: countryTF.text!, email: emailTF.text!, firstname: firstNameTF.text!, profileImage: profileImage.image!, lastname: lastNameTF.text!, password: passwordTF.text!, phone: phoneNoTF.text!, website: websiteTF.text!)
            
            switch accountType {
            case .Model:
                AuthService.shared.registerUser(account: .Artist, credentials: credentials) { (error, ref) in
                    if error == nil{
                        AppDelegate.shared.removeLoadIndIndicator()
                        self.pushToController(from: .Home , identifier: .TabBar)
                    }
                    else{
                        AppDelegate.shared.removeLoadIndIndicator()
                        print(error?.localizedDescription as Any)
                    }
                    
                }
            case .Artist :
            AuthService.shared.registerUser(account: .Artist, credentials: credentials) { (error, ref) in
                if error == nil{
                    AppDelegate.shared.removeLoadIndIndicator()
                    self.pushToController(from: .Home , identifier: .TabBar)
                }
                else{
                    AppDelegate.shared.removeLoadIndIndicator()
                    print(error?.localizedDescription as Any)
                }
            }
            default:
                break
            }
        }
        
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
        if countryTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "password is Empty")
            return false
        }
        if cityTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "phone is Empty")
            return false
        }
        if websiteTF.text!.isEmpty {
            self.presentAlert(withTitle: "Error", message: "website is Empty")
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
