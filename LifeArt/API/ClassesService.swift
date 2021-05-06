//
//  ClassesService.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Firebase
struct ClassModel {
    let address, date, desc: String
    let image: UIImage
    let name, owner, phone, time: String
    let user, web: String
}

struct ClassesService {
    
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    static var shared = ClassesService()
    
    func creatPost(classModel: ClassModel , completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        if let data = classModel.image.pngData() {
            FirebaseStorageManager().uploadImageData(data: data, serverFileName: UUID().uuidString) { (isSuccess, url) in
                guard let url = url else {return}
                guard let uid = Auth.auth().currentUser?.uid else {return}
                let address =  classModel.address
                let date = classModel.date
                let desc = classModel.desc
                let name = classModel.name
                let owner = classModel.owner
                let phone = classModel.phone
                let time = classModel.time
                let web = classModel.web
                
                let values = ["address": address,
                              "date": date,
                              "url": url,
                              "desc": desc,
                              "name": name,
                              "owner" :  owner ,
                              "phone" : phone ,
                              "time" : time,
                              "web" : web,
                              "image" : url,
                              "user" : uid
                ]
                as [String : Any]
                
                REF_Classes.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
                
            }
        }
    }
    func fetchClassess(completion: @escaping([Classess]) -> Void) {
        var ClassessArray = [Classess]()
        REF_Classes.observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let userDict = userSnap.value as! [String:AnyObject]
                let classs = Classess(dictionary: userDict)
                ClassessArray.append(classs)
            }
            DispatchQueue.main.async {
                completion(ClassessArray)
            }
        }
    }
}

