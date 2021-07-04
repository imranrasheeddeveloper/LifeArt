//
//  ChatVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 30/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
class ChatVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var group = DispatchGroup()
    var messageDict : [String:AnyObject]?
    var messageArray = [NewMessagesModel]()
    let semaphore = DispatchSemaphore(value: 1)
    var count : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        registerNib()
        setStatusBar()
        apiCalling(completion: { [self] message , key in
            
            UserService.shared.checkArtistExist(uid: key) { (exist) in
                if exist{
                    UserService.shared.fetchArtistUser(uid: key) { [self] (user) in
                        for dict in message {
                            let message = NewMessagesModel(username: user.firstname, usererImage: user.image, otherUserId: key, user: MessageModel(dictionary: dict.value as! [String : Any]))
                            messageArray.append(message)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
                else{
                    UserService.shared.fetchModelsUser(uid:  key) { [self] (user) in
                        for (i , dict) in message.enumerated(){
                            let messageM = NewMessagesModel(username: user.firstname, usererImage: user.image, otherUserId: key, user: MessageModel(dictionary: dict.value as! [String : Any]))
                            messageArray.append(messageM)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            if i == message.count{
                                print(message.count)
                            }
                            
                        }
                    }
                }
            }
        })
    }
    
    func registerNib() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatDetailCell", bundle: nil), forCellReuseIdentifier: "ChatDetailCell")
    }
    @IBAction func backButtonAction(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
extension ChatVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ChatDetailCell", for: indexPath) as! ChatDetailCell
        cell.cofigureCell(mesageData: messageArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uid = messageArray[indexPath.row].otherUserId
        let Chat = ChatViewController()
        Chat.otherUid = uid
        self.navigationController?.pushViewController(Chat, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    //MARK:- API
    
    func apiCalling(completion: @escaping ([String: AnyObject] , String)->Void){
        
        guard let uid = currentUserID else { return }
        REF_messages.child(uid).observeSingleEvent(of : .value) { [self] (snapshot) in
            for snap in snapshot.children{
                let messageSnap = snap as! DataSnapshot
                messageDict = messageSnap.children as? [String : AnyObject]
                REF_messages.child(uid).child(messageSnap.key).queryLimited(toLast: 1).observeSingleEvent(of : .value) { (snapShot) in
                    let usermessageSnap = snapShot
                    let usermessageDict = usermessageSnap.value as? [String : AnyObject]
                    dump(usermessageDict)
                    completion(usermessageDict ?? [ : ], messageSnap.key)
                    
                }
                // dump(messageDict)
            }
            
        }
        
    }
}

