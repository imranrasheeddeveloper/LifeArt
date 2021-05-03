//
//  AnnouncmentService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Foundation
import Firebase
import FirebaseAuth
struct AnnouncmentService{
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static let shared = UserService()
    func fetchAnnouncmentServices(uid: String, completion: @escaping(User) -> Void) {
        REF_Announcements.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
