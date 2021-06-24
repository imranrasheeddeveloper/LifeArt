//
//  Constant.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Lottie
import SystemConfiguration
import MaterialComponents.MaterialSnackbar
var animationView: AnimationView!
func  addLottieAnimation(string : String ,view : UIView ) {
    animationView = .init(name: string)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    animationView.animationSpeed = 1
    view.addSubview(animationView)
    animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    animationView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    animationView.widthAnchor.constraint(equalToConstant: 250).isActive = true

    animationView.play()
}
func removeLottieAnimation(){
    animationView.removeFromSuperview()
}
func  addLottieAnimationOnAlert(string : String ,view : UIView ) {
    animationView = .init(name: string)
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .loop
    animationView.animationSpeed = 1
    view.addSubview(animationView)
    animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    animationView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    animationView.widthAnchor.constraint(equalToConstant: 64).isActive = true

    animationView.play()
}

func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}

var commentsTag : String = ""
var GlobaluserID : String = ""
var postOwner :  String = ""
let productID : String = "com.lifeArt.app.sub"
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


func snackBar(str : String)  {
    let manager = MDCSnackbarManager()
    let message = MDCSnackbarMessage()
    message.duration = 1
    message.text = str
    manager.show(message)
}
