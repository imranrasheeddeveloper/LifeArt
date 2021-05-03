//
//  UserService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
struct UserService{
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    
    static let shared = UserService()
    
    
    //MARK: - Fetch user
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        REF_Artists.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    //MARK: - updateProfileImage
    
    func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let filename = NSUUID().uuidString
        let ref = STORAGE_PROFILE_IMAGES.child(filename)
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            ref.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                let values = ["image": profileImageUrl]
                
                REF_Artists.child(uid).updateChildValues(values) { (error, ref) in
                    completion(url)
                }
            }
        }
    }
}

