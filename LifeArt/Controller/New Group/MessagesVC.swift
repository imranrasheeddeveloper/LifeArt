//
//  MessagesVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "MessagesCell"

class MessagesVC: UITableViewController {
    
    //MARK: - Properties
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        fetchMessages()
        
    }

    
    
    //MARK: - API
    
    func fetchMessages() {
            guard let currentUid = Auth.auth().currentUser?.uid else {return}
    
            self.messages.removeAll()
            self.messagesDictionary.removeAll()
            self.tableView.reloadData()
    
            REF_messages.child(currentUid).observe(.childAdded) { (snapshot) in
                //print("DEBUG: The message is -> \(snapshot)")
                let uid = snapshot.key
    
                REF_messages.child(currentUid).child(uid).observe(.childAdded) { (snapshot) in
                    //print("DEBUG: The snapshot is -> \(snapshot)")
                    let messageID = snapshot.key
                    self.fetchMessage(withMessageID: messageID)
                }
            }
        }
    
        func fetchMessage(withMessageID messageID: String) {
            REF_messages.child(messageID).observeSingleEvent(of: .value) { (snapshot) in
    
                guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {return}
                let message = Message(dictionary: dictionary)
                let chatPartnerID = message.getChatPartnerID() //chatPartner is the 'key' to present messages with different users
                self.messagesDictionary[chatPartnerID] = message
                self.messages = Array(self.messagesDictionary.values)
                //self.messages.append(message) //not needed anymore
                self.tableView.reloadData()
            }
        }
    
    
    //MARK: - Selectors
    
    @objc func handleNewMessage() {
        print("DEBUG: new message button pressed...")
        let controller = NewMessagesVC()
        controller.messagesController = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
    //MARK: - Heleper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        tableView.register(MessagesCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Messages"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .compose, target: self, action: #selector(handleNewMessage))
        navigationItem.rightBarButtonItem?.tintColor = .customBlackColor
    }
    
    func showChatController(forUser user: User) {
        let chatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.user = user
        navigationController?.pushViewController(chatController, animated: true)
    }
    
}


//MARK: - Extensions

//numberOfRowsInSection, heightForRowAt, cellForRowAt and didSelectRowAt

extension MessagesVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MessagesCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        let chatPartnerID = message.getChatPartnerID()
        UserService.shared.fetchUser(uid: chatPartnerID) { (user) in
            self.showChatController(forUser: user)
        }
    }
}


