//
//  AuthService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 20/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

//MARK:-

struct AuthCredentials {
    let bio, city, country, email: String
    let firstname: String
    var profileImage: UIImage
    let lastname, password, phone, website: String
}

// MARK: - Interest
struct Interest: Codable {
    let name: String
}

enum AccountType {
    case artist
    case moodels
}

struct AuthService {
    static let shared = AuthService()
    
    var isHeicSupported: Bool {
        (CGImageDestinationCopyTypeIdentifiers() as! [String]).contains("public.heic")
    }
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(account : AccountType , credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("DEBUG: Error -> \(error)")
                return
            }
            if let data = credentials.profileImage.pngData() {
                FirebaseStorageManager().uploadImageData(data: data, serverFileName: UUID().uuidString) { (isSuccess, url) in
                    guard let url = url else {return}
                    guard let uid = result?.user.uid else {return}
                    let bio =  credentials.bio
                    let city = credentials.city
                    let country = credentials.country
                    let email = credentials.email
                    let firstname = credentials.firstname
                    let lastname = credentials.lastname
                    let passwrod = credentials.password
                    let phone = credentials.phone
                    let website =  credentials.website
                    let values = ["bio": bio,
                                  "city": city,
                                  "country": country,
                                  "email": email,
                                  "firstname": firstname,
                                  "image" :  url ,
                                  "lastname" :  lastname ,
                                  "passwrod" : passwrod ,
                                  "phone" : phone ,
                                  "website" : website
                    ]
                    as [String : Any]
                    
                    let value = ["port","port","port"]
                    
                    
                    //check if the user is 'Artist' or 'Model'
                    switch account {
                    case .artist :
                        REF_Artists.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    case .moodels:
                        REF_Models.child(uid).updateChildValues(values, withCompletionBlock: completion)
                    }
                    for v in value {
                        REF_Artists.child(uid).child("Interest").childByAutoId().updateChildValues(["name" : v])
                    }
                  
                }
            }
        }
    }
}
