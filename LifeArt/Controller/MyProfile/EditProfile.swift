//
//  EditProfile.swift
//  LifeArt
//
//  Created by Muhammad Imran on 25/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
class EditProfile: UIViewController {
    //MARK:- Delration
    var user : User? {
        didSet{
            firstNameTF.text = user?.firstname
            lastNameTF.text = user?.lastname
            emailTF.text = user?.email
            countryTF.text = user?.country
           // cityTF.text = user?.city
          //  phoneTF.text = user?.phone
            websiteTF.text  = user?.website
            contractNoTF.text = user?.contractNo
            bioTF.text = user?.bio
        }
    }
 
    @IBOutlet weak var navBarView:   UIView!
    @IBOutlet weak var firstNameTF:  UITextField!
    @IBOutlet weak var lastNameTF:   UITextField!
    @IBOutlet weak var emailTF:      UITextField!
    @IBOutlet weak var countryTF:    UITextField!
   // @IBOutlet weak var cityTF:       UITextField!
    @IBOutlet weak var phoneTF:      UITextField!
    @IBOutlet weak var websiteTF:    UITextField!
    @IBOutlet weak var bioTF:        UITextField!
    @IBOutlet weak var contractNoTF: UITextField!
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        loadData()
        setStatusBar()
        hideKeyboard()
        navBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navBarView.dropShadow()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
    }
    
  
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.checkArtistExist(uid: uid) { (result) in
            if result{
                UserService.shared.fetchUser(uid: uid) { [self] (user) in
                    self.user = user
                    
                }
            }
            else{
                UserService.shared.fetchMyModelUser(uid: uid) { [self] (user) in
                    self.user = user
                    
                }
            }
           
        }
       
    }
    //MARK:- Load Data
    func loadData() {
    
       
        

    }
    
    //MARK:- Api Calling
    
    
    func apiCalling() {
        AppDelegate.shared.loadindIndicator(title: "Profile Updating")
        UserService.shared.checkArtistExist(uid: Auth.auth().currentUser!.uid) {[self] (result) in
            
            let profileObj = updateMyProfile(contractNo: contractNoTF.text ?? "", email: emailTF.text ?? "", firstname: firstNameTF.text ?? "", lastname: lastNameTF.text ?? "", country: countryTF.text ?? "", bio: bioTF.text ?? "", website: websiteTF.text ?? "")
            if result {
                UserService.shared.updateProfile(account: .Artist, updateProfile:profileObj) { (error, ref) -> (Void) in
                    print(error?.localizedDescription as Any)
                    AppDelegate.shared.removeLoadIndIndicator()
                }
            }
            else{
                UserService.shared.updateProfile(account: .Artist, updateProfile:profileObj) { (error, ref) -> (Void) in
                    AppDelegate.shared.removeLoadIndIndicator()
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        
    apiCalling()
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}
