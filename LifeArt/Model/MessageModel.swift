//
//  MessageModel.swift
//  LifeArt
//
//  Created by Muhammad Imran on 13/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation


struct NewMModel {
    var userId : String
    var MessageModel : MessageModel
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


struct NewMessagesModel{
    var userId : String
    var user : MessageModel
    
}
struct MessageData {
    let from, message: String
    let seen: Bool
    let time: Int
    let type: String
}

// MARK: - Welcome
struct NewMessages {
    let userId : String
    let newMessagesData: NewMessagesData

}

// MARK: - AjfAy5UYaRPfpCSACL7BQ0J7Ubs1
struct NewMessagesData {
    let newUserMessages : NewUserMessages
 
}

// MARK: - AjfAy5UYaRPfpCsacl7Bq0J7Ubs1
struct NewUserMessages {
    let from: String
    let message: String
    let seen: Bool
    let time: Int
    let type: String
}


