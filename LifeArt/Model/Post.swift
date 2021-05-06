//
//  Post.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation

struct Post {
    var date, desc: String
    var image: String
    var medium, size, time, title: String
    var user: String
    
    init(dictionary: [String: Any]) {
        self.user = dictionary["user"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.medium = dictionary["medium"] as? String ?? ""
        self.size = dictionary["size"] as? String ?? ""
        self.time = dictionary["time"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
    }
    
    
//    init (date :  String , desc : String , image :  String , medium : String , size :  String, time : String, title :  String , user : String) {
//        self.user = user
//        self.date = date
//        self.desc = desc
//        self.image = image
//        self.medium = medium
//        self.size = size
//        self.time = time
//        self.title = title
//    }
}
