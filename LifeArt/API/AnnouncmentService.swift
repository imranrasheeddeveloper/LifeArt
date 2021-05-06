//
//  AnnouncmentService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Foundation
import Firebase
import FirebaseAuth
struct AnnouncmentService{
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static let shared = AnnouncmentService()
    func fetchAnnouncmentServices(completion: @escaping([Announcements]) -> Void) {
        var announcmentArray = [Announcements]()
        REF_Announcements.observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let announcmentDict = userSnap.value as! [String:AnyObject]
                let user = Announcements(dictionary: announcmentDict)
                announcmentArray.append(user)
            }
            DispatchQueue.main.async {
                completion(announcmentArray)
            }
        }
    }
}
