//
//  NewMessagesVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

private let reuseIdentifier = "NewMessagesCell"

class NewMessagesVC: UIViewController {
    
    //MARK: - Properties
    var newMessagesArray = [NewMModel]()
    var users = [User]()
    var messagesController: MessagesVC?
    var uIDArray = [String]()
    var messageArray = [MessageModel]()
    var exist : Bool  = false
    
    var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UINib(nibName: "EditViewCell", bundle: nil), forCellReuseIdentifier: "EditViewCell")
        return tv
    }()
    
    var navigationBarView : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dropShadow()
        v.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        return v
    }()
    
    var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        return button
    }()
    
    var navBarLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "New Message"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        getNewMessages()
        setStatusBar()
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }
    
    //MARK:- Selector
    
    @objc func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - API

    
    func getUser(){
        for userId in uIDArray{
            REF_messages.observe(.childAdded) { [self] (snapshot) in
                     UserService.shared.checkArtistExist(uid: userId, completion: { (result) in
                        if result{
                            UserService.shared.fetchArtistUser(uid: userId) { (user) in
                                self.users.append(user)
                                self.tableView.reloadData()
                            }
                        }
                        else{
                            UserService.shared.fetchModelsUser(uid: userId) { (user) in
                                self.users.append(user)
                                self.tableView.reloadData()
                            }
                        }
                    })
                
            }
            
        }
    }
    
    
    //MARK:-  New Logic
    
    
    func getNewMessages() {
        newMessagesArray.removeAll()
        let currentUid = Auth.auth().currentUser?.uid
        //var userDict :  [String:AnyObject]?
        REF_messages.child(currentUid!).observe(.value) { [self]  (snapshot) in
            guard let userDict = snapshot.value as? [String : AnyObject] else {return}
            for (mykey,values) in userDict{
                uIDArray.append(mykey)
                 let val = values as? [String : AnyObject]
                for (key , value ) in  val!{
                    print("\(key) \(value)")
                    newMessagesArray.append(NewMModel(userId: mykey , MessageModel: MessageModel(dictionary: value as! [String : Any])))
                }
            }
            self.getUser()
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
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navBarLabel)
        self.view.addSubview(tableView)
        
        navigationBarView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        
        backButton.anchor( left: navigationBarView.leftAnchor, paddingLeft: 20, width: 24, height: 24)
        backButton.centerY(inView: navigationBarView)
        navBarLabel.anchor(top: navigationBarView.topAnchor  , paddingTop: 10)
        navBarLabel.centerX(inView: navigationBarView)
        navBarLabel.centerY(inView: navBarLabel)
        
        tableView.anchor(top: navigationBarView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}


//MARK: - numberOfRowsInSection, heightForRowAt, cellForRowAt and didSelectRowAt

extension NewMessagesVC {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewMessagesCell

        cell.userFullnameLabel.text = users[indexPath.row].firstname
        cell.profileImageView.sd_setImage(with: URL(string: users[indexPath.row].image))
        
        if newMessagesArray[indexPath.row].userId == users[indexPath.row].uid{
            cell.messageLabel.text = newMessagesArray[indexPath.row].MessageModel.message
            cell.timeLabel.text = String(newMessagesArray[indexPath.row].MessageModel.time)
        }
        
        //cell.messageLabel.text = messageArray[indexPath.row].message
       
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: did select row at \(indexPath.row)...")
        
        self.dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.messagesController?.showChatController(forUser: user)
        }
        
    }
}
