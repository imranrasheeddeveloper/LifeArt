//
//  PostService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import  Firebase

struct CreatePost {
    var date, desc: String
    var image: UIImage
    var medium, size, time, title: String
    var user: String
}
struct PostService{
   
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static var shared = PostService()
    public var user: User?
   
    
    //MARK: - Fetch Post
    mutating func fetchPost(completion: @escaping([Post]) -> Void) {
        var postArray = [Post]()
        REF_Posts.child("artists").observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                let userDict = userSnap.value as! [String:AnyObject]
                let post = Post(key: userSnap.key, postData: PostData(dictionary: userDict))
                postArray.append(post)
            }
            DispatchQueue.main.async {
                completion(postArray)
            }
        }
    }
    
    mutating func fetchPostOfModel(completion: @escaping([Post]) -> Void) {
        var postArray = [Post]()
        REF_Posts.child("models").observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                print(userSnap.key)
                let userDict = userSnap.value as! [String:AnyObject]
                let post = Post(key: userSnap.key, postData: PostData(dictionary: userDict))
                postArray.append(post)
            }
            DispatchQueue.main.async {
                completion(postArray)
            }
        }
    }
    

    
    func creatPost(account : AccountType , post: CreatePost , completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        AppDelegate.shared.loadindIndicator(title: "Uploading Post")
        if let data = post.image.pngData() {
            FirebaseStorageManager().uploadImageData(data: data, serverFileName: UUID().uuidString) { (isSuccess, url) in
                guard let url = url else {return}
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let date =  post.date
                let desc = post.desc
                let medium = post.medium
                let size = post.size
                let time = post.time
                let title = post.title
                let values = ["date": date,
                              "desc": desc,
                              "image": url,
                              "medium": medium,
                              "size": size,
                              "time" :  time,
                              "title" : title,
                              "user" : uid,
                ]
                as [String : Any]
                //check if the user is 'Artist' or 'Model'
                switch account {
                case .Artist :
                    REF_Posts.child("artists").childByAutoId().updateChildValues(values, withCompletionBlock: completion)
                case .Model:
                    REF_Posts.child("models").childByAutoId().updateChildValues(values, withCompletionBlock: completion)
                }
                AppDelegate.shared.removeLoadIndIndicator()
            }
        }
    }
    
    
    func reportPost(postUserId : String,  completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = [UUID().uuidString: postUserId]
        as [String : Any]
      
            REF_Reported_Posts.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
    
    func likePost(postId : String,  completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = [uid: true] as [String : Any]
        REF_Likes.child(postId).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func unLikePost(postId : String,  completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        REF_Likes.child(postId).child(uid).removeValue()
    }
    
    func fetchLikesOnPost(postId : String , completion: @escaping(UInt) -> Void) {
        REF_Likes.child(postId).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.childrenCount)
        }
    }
    
    func fetchNumberOfComments(postId : String , completion: @escaping(UInt) -> Void) {
        REF_Comments.child(postId).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.childrenCount)
        }
    }
    
    
   
    func fetchLikes(completion: @escaping() -> Void) {
       REF_Likes.observeSingleEvent(of: .value) { (snapshot) in
          
           for snap in snapshot.children {
               let userSnap = snap as! DataSnapshot
               let userDict = userSnap.value as! [String:AnyObject]
               let postID = userSnap.key
            for (key , value) in userDict{
                _ = PostLikes(postID: postID, data: postLikeData(userID: key, like: value as? Int))
            }
           }
       }
   }
    func fetchLikesGallery(completion: @escaping([PostLikes]) -> Void) {
       var postLikeArray = [PostLikes]()
       REF_Likes.observeSingleEvent(of: .value) { (snapshot) in
          
           for snap in snapshot.children {
               let userSnap = snap as! DataSnapshot
               let userDict = userSnap.value as! [String:AnyObject]
               let postID = userSnap.key
            for (key , value) in userDict{
               let obj = PostLikes(postID: postID, data: postLikeData(userID: key, like: value as? Int))
                postLikeArray.append(obj)
            }
           }
        completion(postLikeArray)
       }
   }
    
    func deletePost(childID : String , completional : @escaping(Bool) -> Void) {
    
        REF_Posts.child("artists").child(childID).removeValue { error, _ in
            if error != nil {
                print(error as Any)
                completional(false)
            }
            else{
                completional(true)
            }
        }
    }
}

struct PostLikes {
    let postID : String?
    let data : postLikeData?

}

struct postLikeData {
    var userID : String?
    var like : Int?
}
