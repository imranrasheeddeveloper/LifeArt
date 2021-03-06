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

struct updateMyProfile {
    let contractNo, email: String
    let firstname: String
    let lastname ,country, bio, website: String
    
}

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
    
    func fetchMyModelUser(uid: String, completion: @escaping(User) -> Void) {
        REF_Models.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            dump(user)
            completion(user)
        }
    }
    
    
    func fetchModelsUser(uid: String, completion: @escaping(User) -> Void) {

        REF_Models.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            dump(user)
            completion(user)

        }
    }
    
    func fetchArtistUser(uid: String, completion: @escaping(User) -> Void) {
        REF_Artists.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            snapshot.exists()
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            dump(user)
            completion(user)
        }
    }
    func fetchArtist(completion: @escaping([UserModel]) -> Void) {
        var artistArray = [UserModel]()
        REF_Artists.observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                var userDict = userSnap.value as! [String:AnyObject]
                userDict["user"] = userSnap.key as AnyObject
                let user = UserModel(dictionary: userDict)
                artistArray.append(user)
            }
            DispatchQueue.main.async {
                completion(artistArray)
            }
           
        }
    }
    
    func fetchModels(completion: @escaping([UserModel]) -> Void) {
        var postArray = [UserModel]()
        REF_Models.observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                var userDict = userSnap.value as! [String:AnyObject]
                userDict["user"] = userSnap.key as AnyObject
                let post = UserModel(dictionary: userDict)
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
    func checkArtistExist(uid: String, completion: @escaping(Bool) -> Void) {
        REF_Artists.child(uid).observe(.value) {(snapshot) in
            if snapshot.exists() {
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    
    
    
    func updateProfile(account : AccountType , updateProfile: updateMyProfile, completion: @escaping(Error?, DatabaseReference) -> (Void)) {
      
        let uid = Auth.auth().currentUser!.uid
                  
                    let country = updateProfile.country
                    let email = updateProfile.email
                    let firstname = updateProfile.firstname
                    let lastname = updateProfile.lastname
                    //let phone = updateProfile.phone
                    let website =  updateProfile.website
                    let contractNo = updateProfile.contractNo
                    let bio = updateProfile.bio
                    
                    //check if the user is 'Artist' or 'Model'
                    switch account {
                    case .Artist :
                        let value  = valuesDictionry(country: country, email: email, firstname: firstname, lastName: lastname, website: website, bio: bio, contractNo: contractNo)
                        
                        REF_Artists.child(uid).updateChildValues(value, withCompletionBlock: completion)
                   
                    case .Model:
                        let value  = valuesDictionry(country: country, email: email, firstname: firstname, lastName: lastname, website: website, bio: bio, contractNo: contractNo)
                        
                        REF_Models.child(uid).updateChildValues(value, withCompletionBlock: completion)
                        
        }

    }
    
    func valuesDictionry(country : String, email :  String , firstname : String , lastName : String ,website : String, bio : String, contractNo : String) -> [String : Any] {
       return [
                     "contractNo" : contractNo,
                      "country": country,
                      "email": email,
                      "firstname": firstname,
                      "lastname" :  lastName ,
                      "bio" : bio,
                      "website" : website ,
        ]
        as [String : Any]
    }
    
    func searchArtist(name: String) {
            let databaseRef = Database.database().reference().child("Artist")
            let query = databaseRef.queryOrdered(byChild: "firstname").queryStarting(atValue: name).queryEnding(atValue: "\(name)\\uf8ff")

            query.observeSingleEvent(of: .value) { (snapshot) in
                guard snapshot.exists() != false else { return }
                print(snapshot.value)
                DispatchQueue.main.async {
                    // Update TextFields here
                }
            }
    }
 }

