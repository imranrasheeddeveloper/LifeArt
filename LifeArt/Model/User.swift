//
//  User.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
struct User {
    let uid: String
    //    let interests: [String: Interest]
    let bio, city, country, email: String
    let contractNo : String
    let firstname: String
    let image: String
    let lastname, password, phone, website , type: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.bio = dictionary["bio"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? "456"
        self.email = dictionary["email"] as? String ?? ""
        self.firstname = dictionary["firstname"] as? String ?? ""
        self.lastname = dictionary["lastname"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.website = dictionary["website"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.contractNo = dictionary["phone"] as? String ?? ""
    }
}


struct UserModel {
    let user: String
    let bio, city, country, email: String
    let firstname: String
    let image: String
    let lastname, password, phone, website , type: String
    let contractNo : String
    let lat , lon : Double

    init(dictionary: [String: Any]) {
        self.user = dictionary["user"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.country = dictionary["country"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.firstname = dictionary["firstname"] as? String ?? ""
        self.lastname = dictionary["lastname"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.website = dictionary["website"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.contractNo = dictionary["contractNo"] as? String ?? ""
        self.lat = dictionary["lat"] as? Double ??  0.00
        self.lon = dictionary["lon"] as? Double ?? 0.00
        
    }
}
