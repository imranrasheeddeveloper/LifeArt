//
//  CommentsService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 21/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct CreateComment{
    let comment, date : String
    let time: Int
}
struct CommentsService{
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static let shared = CommentsService()
    func fetchCommentstServices(completion: @escaping([Comments]) -> Void) {
        var commentsArray = [Comments]()
        REF_Comments.observeSingleEvent(of: .value) { (snapshot) in
            guard let commentsDict = (snapshot.value as? [String:AnyObject]) else{return}
            for (commentkey,values) in commentsDict{
                let val = values as? [String : AnyObject]
                for (_ , value) in val! {
                    print(commentsTag)
                    print(commentkey)
                    if commentkey == commentsTag{
                        commentsArray.append(Comments(key: commentkey, commentsData: CommentsData(dictionary: value as! [String : AnyObject])))
                    }
                    
                }
            }
            DispatchQueue.main.async {
                completion(commentsArray)
            }
        }
    }
    
    func creatComment(key : String , comment: CreateComment , completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let comments =  comment.comment
        let date = comment.date
        let from = uid
        let time = comment.time
        let values = ["comment": comments,
                      "date": date,
                      "from": from,
                      "time": time,
        ]
        as [String : Any]
        REF_Comments.child(key).child("\(uid)\(currentTime())").updateChildValues(values, withCompletionBlock: completion)
        
    }
}
