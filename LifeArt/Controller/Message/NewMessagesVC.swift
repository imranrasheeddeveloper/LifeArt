//
//  NewMessagesVC.swift
//  GigimotApp
//
//  Created by Arseni Santashev on 20.10.2020.
//  Copyright © 2020 Numin Consulting. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

private let reuseIdentifier = "NewMessagesCell"

class NewMessagesVC: UITableViewController {
    
    //MARK: - Properties
    
    var users = [User]()
    var messagesController: MessagesVC?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        fetchUsers()
    }
    
    
    //MARK: - API
    
    func fetchUsers() {
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            if uid != Auth.auth().currentUser?.uid {
                UserService.shared.fetchUser(uid: uid) { (user) in
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: - Selectors
    
    @objc func handleCancelNewMessage() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: - Heleper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        tableView.register(NewMessagesCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "New Message"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelNewMessage))
        navigationItem.rightBarButtonItem?.tintColor = .customBlackColor
    }

    
}


//MARK: - numberOfRowsInSection, heightForRowAt, cellForRowAt and didSelectRowAt

extension NewMessagesVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewMessagesCell
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: did select row at \(indexPath.row)...")
        
        self.dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.messagesController?.showChatController(forUser: user)
        }
        
    }
}
