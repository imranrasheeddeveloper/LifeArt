//
//  Constant.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation

var commentsTag : String = ""
var GlobaluserID : String = ""
var postOwner :  String = ""
let productID : String = "com.life.LifeArt.subscription"
 func currentTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    return "\(hour):\(minutes) :\(seconds)"
}

func currentTimeInInteger() -> String {
   let date = Date()
   let calendar = Calendar.current
   let hour = calendar.component(.hour, from: date)
   let minutes = calendar.component(.minute, from: date)
   return "\(hour)\(minutes)"
}
 func currentDate() -> String {
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let year = calendar.component(.year, from: date)
    return "\(day)-\(month)-\(year)"
}
enum MenuClick {
    case editPost
    case deletePost
    case reportPost
}
var menuClick : MenuClick?

var postTag : Int?

var arrayOfPosts = [Post]()


