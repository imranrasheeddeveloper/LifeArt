//
//  Announcements.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
struct Announcements {
    let date, des, name, salary: String
    let time, title, user: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.date = dictionary["date"] as! String
        self.des = dictionary["des"] as! String
        self.name = dictionary["name"] as! String
        self.salary = dictionary["salary"] as! String
        self.time = dictionary["time"] as! String
        self.title = dictionary["title"] as! String
        self.user = dictionary["user"] as! String
    }
}
