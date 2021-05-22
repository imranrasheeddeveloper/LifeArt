//
//  ChatController.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//
import UIKit
import Firebase

private let reuseIdentifier = "ChatCell"

class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    
    var user: User?
    var messages = [Message]()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = .init(width: 0, height: -8)
        view.layer.shadowColor = UIColor.lightGray.cgColor
        
        view.addSubview(sendButton)
        sendButton.anchor(right: view.rightAnchor, paddingRight: 15, width: 40)
        sendButton.centerY(inView: view)
        
        view.addSubview(messageTextField)
        messageTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: sendButton.leftAnchor, paddingLeft: 15, paddingRight: 5)
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = .lightGray
        view.addSubview(separatorLine)
        separatorLine.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 0.5)
        
        return view
    }()
    
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.tintColor = .customBlackColor
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(collectionViewLayout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observeMessages()
        configureNavigationBar()
        
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
   // hides tab bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //unhides tab bar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    //MARK: - API
    
    func uploadMessageToServer(withProperties properties: [String: AnyObject]) {
        
        guard let messageText = messageTextField.text else {return}
        guard let currentUid = Auth.auth().currentUser?.uid else { return } //fromID
        guard let user = self.user else {return} //toID doesnt work
   
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        // UPDATE: - Safely unwrapped uid to work with Firebase 5
        let uid = user.uid 
        
        var values: [String: AnyObject] = ["messageText": messageText as AnyObject,
                                           "toID": user.uid as AnyObject,
                                           "fromID": currentUid as AnyObject,
                                           "creationDate": creationDate as AnyObject]
        
        properties.forEach({values[$0] = $1})
        
        let messageRef = REF_messages.childByAutoId()
        
        // UPDATE: - Safely unwrapped messageKey to work with Firebase 5
        guard let messageKey = messageRef.key else { return }
        
        messageRef.updateChildValues(values) { (err, ref) in
            REF_messages.child(currentUid).child(uid).updateChildValues([messageKey: 1])
            REF_messages.child(uid).child(currentUid).updateChildValues([messageKey: 1])
        }
    }
    
    func observeMessages(){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        guard let chatPartnerID = self.user?.uid else {return}
        
        REF_messages.child(currentUid).child(chatPartnerID).observe(.childAdded) { (snapshot) in
            let messageID = snapshot.key
            
            self.fetchMessage(withMessageID: messageID)
        }
    }
    
    //MARK: - Selectors
    
    @objc func sendButtonPressed() {
        print("DEBUG: 'Send' button pressed...")
        
        guard let messageText = messageTextField.text else {return}
        guard let currentUid = Auth.auth().currentUser?.uid else {return} //fromID
        guard let user = self.user else {return} //toID doesnt work
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        let properties = ["messageText": messageText as AnyObject,
                          "toID": user.uid as AnyObject,
                          "fromID": currentUid as AnyObject,
                          "creationDate": creationDate as AnyObject]
        uploadMessageToServer(withProperties: properties)
        messageTextField.text = nil
        
    }

    //not needed anymore
//    @objc func handleExpertProfile() {
//        let expertProfileController = ExpertProfileController()
//        //expertProfileController.user = user
//        navigationController?.pushViewController(expertProfileController, animated: true)
//    }
    
    
    //MARK: - Helper Functions
    
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        collectionView.autoresizingMask = .flexibleHeight
    }
    
    func configureNavigationBar() {
        guard let user = user else {return}
        navigationItem.title = user.firstname
        
        //not needed anymore
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleExpertProfile))
    }
    
    func fetchMessage(withMessageID messageID: String) {
        REF_messages.child(messageID).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {return}
            
            let message = Message(dictionary: dictionary)
            self.messages.append(message)
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           var height: CGFloat = 80
           
           let message = messages[indexPath.item]
           height = estimateFrameForText(message.messageText).height + 20
           
           return CGSize(width: view.frame.width, height: height)
       }
    
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return messages.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        cell.message = messages[indexPath.item]
        cell.delegate = self
        configureMessage(cell: cell, message: messages[indexPath.item]) //configuring text and bubbleviews
        return cell
    }
 
    // This is how we create a frame for the messages (top, left, bottom, right)
     func estimateFrameForText(_ text: String) -> CGRect {
         let size = CGSize(width: 200, height: 1000)
         let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
         return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
     }
    
    func configureMessage(cell: ChatCell, message: Message) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        //sets the width of the text
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(message.messageText).width + 32
        //sets the height of the message based on the message text
        cell.frame.size.height = estimateFrameForText(message.messageText).height + 20
        
        //configure cell based whether or not it is us or someone else
        if message.fromID == currentUid {
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleView.backgroundColor = .customBlueColor
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true
        } else {
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleView.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
            cell.textView.textColor = .black
            cell.profileImageView.isHidden = false
        }
    }

}

//ChatCellDelegate
extension ChatController: ChatCellDelegate {
    func handleProfileImageTapped(_ cell: ChatCell) {
       //TODO: fetch user from message -> fromID
        //let expertProfileController = ExpertProfileController()
        //navigationController?.pushViewController(expertProfileController, animated: true)
    }
}
