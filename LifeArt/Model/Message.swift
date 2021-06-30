//
//  Message.swift
//  GigimotApp
//
//  Created by Arseni Santashev on 09.10.2020.
//  Copyright © 2020 Numin Consulting. All rights reserved.
//

import Foundation
import Firebase
//
//class Message {
//    
//    var messageText: String!
//    var fromID: String!
//    var toID: String!
//    var creationDate: Date!
//    
//    init(dictionary: Dictionary<String, AnyObject>) {
//        if let messageText = dictionary["messageText"] as? String {
//            self.messageText = messageText
//        }
//        if let fromID = dictionary["fromID"] as? String {
//            self.fromID = fromID
//        }
//        if let toID = dictionary["toID"] as? String {
//            self.toID = toID
//        }
//        if let creationDate = dictionary["creationDate"] as? Double {
//            self.creationDate = Date(timeIntervalSince1970: creationDate)
//        }
//    }
//    
//    func getChatPartnerID() -> String {
//        guard let currentUid = Auth.auth().currentUser?.uid else {return ""}
//        
//        if fromID == currentUid {
//            return toID
//        } else {
//            return fromID
//        }
//    }
//}
