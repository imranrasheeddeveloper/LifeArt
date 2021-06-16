//
//  TabbarVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseAuth

class TabbarVC: UITabBarController {

    public var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
                    saveUserDataInLocal()
                }
            }
            else{
                UserService.shared.fetchMyModelUser(uid: uid) { [self] (user) in
                    self.user = user
                    saveUserDataInLocal()
                }
            }
        }
    }
    
    func saveUserDataInLocal() {
        KeychainWrapper.standard.set(user?.bio ?? "", forKey: "bio")
        KeychainWrapper.standard.set(user?.city ?? "", forKey: "city")
        KeychainWrapper.standard.set(user?.country ?? "", forKey: "country")
        KeychainWrapper.standard.set(user?.email ?? "", forKey: "email")
        KeychainWrapper.standard.set(user?.firstname ?? "", forKey: "firstname")
        KeychainWrapper.standard.set(user?.image ?? "", forKey: "image")
        KeychainWrapper.standard.set(user?.lastname ?? "", forKey: "lastname")
        KeychainWrapper.standard.set(user?.password ?? "", forKey: "password")
        KeychainWrapper.standard.set(user?.phone ?? "", forKey: "phone")
        KeychainWrapper.standard.set(user?.website ?? "", forKey: "website")
        
        KeychainWrapper.standard.set(user?.website ?? "", forKey: "currentUserType")
        UserDefaults.standard.setValue(true, forKey: "isLogedIn")
    }
}
