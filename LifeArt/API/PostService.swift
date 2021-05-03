//
//  PostService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import  Firebase
struct PostService{
   
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static var shared = PostService()
   
    
    //MARK: - Fetch Post
    mutating func fetchPost(completion: @escaping([Post]) -> Void) {
        var postArray = [Post]()
        REF_Posts.child("artists").observeSingleEvent(of: .value) { (snapshot) in
            //guard let dictionary = snapshot.value as? [String: Any] else {return}
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                //let uid = userSnap.key //the uid of each user
                let userDict = userSnap.value as! [String:AnyObject]
                let post = Post(dictionary: userDict)
                postArray.append(post)
            }
            DispatchQueue.main.async {
                completion(postArray)
            }
           
        }
    }
    
}
