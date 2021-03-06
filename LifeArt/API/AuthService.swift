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
import FirebaseAuth
//MARK:-

struct AuthCredentials {
    let bio, city, country, email: String
    let firstname: String
    var profileImage: UIImage
    let lastname, password, phone, website: String
    let lat , lon : Double
    
}

// MARK: - Interest
struct Interest: Codable {
    let name: String
}

enum AccountType {
    case Artist
    case Model
}


struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(account : AccountType , credentials: AuthCredentials, value :  [String] , completion: @escaping(Error?, DatabaseReference?) -> (Void)) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                completion(error , nil)
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
                    let lat = credentials.lat
                    let lon = credentials.lon
                  
                    
                    //check if the user is 'Artist' or 'Model'
                    switch account {
                    case .Artist :
                        let values = dictionry(bio: bio, city: city, country: country, email: email, firstname: firstname, lastName: lastname, url: url, lastname: lastname, passwrod: passwrod, phone: phone, website: website, type: "Artist" , lat: lat , lon: lon)
                        REF_Artists.child(uid).updateChildValues(values, withCompletionBlock: completion)
                        for v in value {
                            REF_Artists.child(uid).child("Interest").childByAutoId().updateChildValues(["name" : v])
                        }
                    case .Model:
                        let values = dictionry(bio: bio, city: city, country: country, email: email, firstname: firstname, lastName: lastname, url: url, lastname: lastname, passwrod: passwrod, phone: phone, website: website, type: "Model" , lat: lat , lon: lon)
                        
                        REF_Models.child(uid).updateChildValues(values, withCompletionBlock: completion)
                        for v in value {
                            REF_Models.child(uid).child("Interest").childByAutoId().updateChildValues(["name" : v])
                        }
                    }
                }
            }
        }
    }
    func dictionry(bio : String , city : String , country : String, email :  String , firstname : String , lastName : String , url : String , lastname : String , passwrod : String , phone : String , website : String , type : String , lat : Double , lon :  Double) -> [String : Any] {
       return ["bio": bio,
                      "city": city,
                      "country": country,
                      "email": email,
                      "firstname": firstname,
                      "image" :  url ,
                      "lastname" :  lastname ,
                      "passwrod" : passwrod ,
                      "phone" : phone ,
                      "website" : website ,
                      "type" : type ,
                      "lat" : lat ,
                      "lon" : lon
        ]
        as [String : Any]
    }
}
