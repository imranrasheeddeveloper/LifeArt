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
    var password  : String!
   
    var firstName  : String!
    var lastName  : String!
    var email  : String!
    var country  : String!
    var city  : String!
    var phoneNo  : String!
    var website : String!
    
    
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
    
    func createAccount() {
        guard let profilephoto = profileImage.image else {self.presentAlert(withTitle: "Error", message: "Select Profile Image")
                return }
        guard let firstName = firstNameTF.text else {
                self.presentAlert(withTitle: "Error", message: "First Name is Empty")
                return}
        guard let lastName = lastNameTF.text else {
                self.presentAlert(withTitle: "Error", message: "Last Name is Empty")
                return}
        guard let email = emailTF.text else {
                self.presentAlert(withTitle: "Error", message: "email is Empty")
                return }
        guard let country = countryTF.text else {
                self.presentAlert(withTitle: "Error", message: "email is Empty")
                return }
        guard let city = cityTF.text else {
                self.presentAlert(withTitle: "Error", message: "email is Empty")
                return }
        guard let phone = phoneNoTF.text else {
                self.presentAlert(withTitle: "Error", message: "email is Empty")
                return }
        guard let website = websiteTF.text else {
                self.presentAlert(withTitle: "Error", message: "email is Empty")
                return }

        let credentials =   AuthCredentials(bio: "Test", city: city, country: country, email: email, firstname: firstName, profileImage: profilephoto, lastname: lastName, password: password, phone: phone, website: website)
        AppDelegate.shared.loadindIndicator(title: "Creating Account")
        switch accountType {
        case .moodels:
            AuthService.shared.registerUser(account: .artist, credentials: credentials) { (error, ref) in
                if error == nil{
                    AppDelegate.shared.removeLoadIndIndicator()
                    self.pushToController(from: .Home , identifier: .TabBar)
                }
                else{
                    AppDelegate.shared.removeLoadIndIndicator()
                    print(error?.localizedDescription as Any)
                }
                
            }
        case .artist :
        AuthService.shared.registerUser(account: .artist, credentials: credentials) { (error, ref) in
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

extension CreateProfileVC : UIScrollViewDelegate {
//    func setupGestureRecognizer() {
//        UIGestureRecognizer.init(addToView: profileImage, closure: { [self] in
//            self.present(imagePicker, animated: true, completion: nil)
//
//        })
//    }
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
