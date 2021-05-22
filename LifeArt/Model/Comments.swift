//
//  Comments.swift
//  LifeArt
//
//  Created by Muhammad Imran on 22/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation


struct Comments {
    var key : String
    var commentsData :  CommentsData
}

struct CommentsData {
    let comment, date, from: String
    let time: Int
    
    init(dictionary: [String: AnyObject]) {  
        self.comment = dictionary["comment"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.from = dictionary["from"] as? String ?? ""
        self.time = dictionary["time"] as? Int ?? 0
    }
}
