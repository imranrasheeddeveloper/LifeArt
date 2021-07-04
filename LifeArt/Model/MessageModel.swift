//
//  MessageModel.swift
//  LifeArt
//
//  Created by Muhammad Imran on 13/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation

struct NewMessagesModel{
    var username : String
    var usererImage : String
    var otherUserId : String
    var user : MessageModel
    
}

struct MessageModel {
    
    let from, message: String
    let seen: Bool
    let time: Int
    let type: String
    init(dictionary: [String: Any]) {
        self.from = dictionary["from"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
        self.time = dictionary["time"] as? Int ?? 0
        self.type = dictionary["type"] as? String ?? ""
        self.seen = dictionary["seen"] as? Bool ?? false
    }
    
}




