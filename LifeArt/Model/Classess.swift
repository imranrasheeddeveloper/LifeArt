//
//  Classess.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation

struct Classess {
    let address, date, desc: String
    let image: String
    let name, owner, phone, time: String
    let user, web: String
    
    
    init(dictionary: [String: Any]) {
        self.address = dictionary["address"] as? String ?? ""
        self.date = dictionary["date"] as? String ?? ""
        self.desc = dictionary["desc"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.owner = dictionary["owner"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.time = dictionary["time"] as? String ?? ""
        self.user = dictionary["user"] as? String ?? ""
        self.web = dictionary["web"] as? String ?? ""
    }
    
}
