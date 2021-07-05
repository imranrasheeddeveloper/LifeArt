//
//  Constant.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//
import UIKit
import Foundation
import Lottie
import SystemConfiguration
import MaterialComponents.MaterialSnackbar
import Firebase

var currentUserID = Auth.auth().currentUser?.uid
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
    case deletePost

}
var menuClick : MenuClick?

var postTag : Int?

func snackBar(str : String)  {
    let manager = MDCSnackbarManager()
    let message = MDCSnackbarMessage()
    message.duration = 1
    message.text = str
    manager.show(message)
}
func showError(viewController : UIViewController) {
    let storyBoard = UIStoryboard(name: "Alerts", bundle: nil)
    let customAlert = storyBoard.instantiateViewController(withIdentifier: "ErrorVC") as! ErrorVC
    customAlert.providesPresentationContextTransitionStyle = true
    customAlert.definesPresentationContext = true
    customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    viewController.present(customAlert, animated: true, completion: nil)
}

func Success(viewController : UIViewController) {
    let storyBoard = UIStoryboard(name: "Alerts", bundle: nil)
    let customAlert = storyBoard.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
    customAlert.providesPresentationContextTransitionStyle = true
    customAlert.definesPresentationContext = true
    customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    viewController.present(customAlert, animated: true, completion: nil)
}
func showLocationAccessAlert() {
       let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
       let okAction = UIAlertAction(title: "settings", style: .default, handler: {(cAlertAction) in
           UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
       })
       let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel)
       alertController.addAction(cancelAction)
       alertController.addAction(okAction)
       let appdelegate = UIApplication.shared.delegate as? AppDelegate
       appdelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
   }

func listenForAllChildEvents(atPath path: String, completion: @escaping(_ snapshot: DataSnapshot?, _ error: Error?, _ eventType: DataEventType?) -> ()) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let itemRef = ref.root.child(path)
        itemRef.observe(.childAdded, with: { (snapshot) in
            completion(snapshot,nil,DataEventType.childAdded)
        }) { (error) in
            completion(nil,error,nil)
        }
        itemRef.observe(.childMoved, with: { (snapshot) in
            completion(snapshot,nil,DataEventType.childMoved)
        }) { (error) in
            completion(nil,error,nil)
        }
        itemRef.observe(.childRemoved, with: { (snapshot) in
            completion(snapshot,nil,DataEventType.childRemoved)
        }) { (error) in
            completion(nil,error,nil)
        }
        itemRef.observe(.childChanged, with: { (snapshot) in
            completion(snapshot,nil,DataEventType.childChanged)
        }) { (error) in
            completion(nil,error,nil)
        }
    }

extension Double {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                }
            })
            
        }).resume()
    }
    
}
