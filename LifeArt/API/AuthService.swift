//
//  AuthService.swift
//  GigimotApp
//
//  Created by Arseni Santashev on 06.10.2020.
//  Copyright © 2020 Numin Consulting. All rights reserved.
//

import UIKit
import Firebase
import GeoFire

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    //let username: String
    let accountType: Int //NEW
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    private var location = LocationHandler.shared.locationManager.location
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        //let username = credentials.username
        let account = credentials.accountType //NEW
        //let profileImage = credentials.profileImage
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error -> \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email": email,
                                  "password": password,
                                  "fullname": fullname,
                                 // "username": username,
                                  "accountType": account, //NEW
                                  "profileImageUrl": profileImageUrl] as [String : Any] //NEW: as [String: Any]
                    
                   // let sharedLocationManager = LocationHandler.shared.locationManager <- do i need this here?
                    
                    //check if the user is 'Client' or 'Expert'
                    if account == 1 {
                        let geofire = GeoFire(firebaseRef: REF_EXPERT_LOCATIONS)
                        guard let location = self.location else {return}
                        print("DEBUG: Expert profile was succsessfully created")
                        
                        //Save user info to database
                        geofire.setLocation(location, forKey: uid) { (error) in
                            REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                        }
                    }
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
