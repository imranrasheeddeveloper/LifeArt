//
//  FirebaseConstant.swift
//  LifeArt
//
//  Created by Muhammad Imran on 20/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
let DB_REF = Database.database().reference()
let REF_Models = DB_REF.child("Models")
let REF_Likes = DB_REF.child("Likes")
let REF_Comments = DB_REF.child("Comments")
let REF_Classes = DB_REF.child("Classes")
let REF_Chat = DB_REF.child("Chat")
let REF_Artists = DB_REF.child("Artists")
let REF_Announcements = DB_REF.child("Announcements")
let REF_Posts = DB_REF.child("Posts")
let REF_messages = DB_REF.child("messages")



typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
