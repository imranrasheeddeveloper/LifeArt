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
        print(uid)
        REF_Artists.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            dump(user)
            completion(user)
            
        }
    }
    
    func fetchArtist(completion: @escaping([User]) -> Void) {
        var artistArray = [User]()
        REF_Artists.observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                let userDict = userSnap.value as! [String:AnyObject]
                let user = User(uid: "", dictionary: userDict)
                artistArray.append(user)
            }
            DispatchQueue.main.async {
                completion(artistArray)
            }
           
        }
    }
    
    func fetchModels(completion: @escaping([User]) -> Void) {
        var postArray = [User]()
        REF_Models.observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                let userDict = userSnap.value as! [String:AnyObject]
                let post = User(uid: "", dictionary: userDict)
                postArray.append(post)
            }
            DispatchQueue.main.async {
                completion(postArray)
            }
           
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
    
    func updateProfile() {
       
    }
}

