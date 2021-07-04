//
//  ChatVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 06/07/2019.
//  Copyright © 2019 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase
import SDWebImage

struct Sender : SenderType {
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

class ChatViewController: MessagesViewController, MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate, MessageCellDelegate {
    
    
    //MARK:- varibale Delration
    var currentUsermessageDict : [String:AnyObject]?
    var otherUserMessageDict : [String:AnyObject]?
    let currentUser = Sender(senderId: "self", displayName: "Imran")
    let otherUser = Sender(senderId: "other", displayName: "Bilal")
    var messages = [MessageType]()
    var otherUid :  String?
    var currentUserData : User?
    var otherUserData : User?
    var messageArray = [MessageModel]()
    var count = 0
    typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)
    
    //MARK:- Life Cycels
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageIncomingAvatarSize(.zero)
            layout.setMessageOutgoingAvatarSize(.zero)
        }
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.checkArtistExist(uid: uid) { (result) in
            if result{
                UserService.shared.fetchUser(uid: uid) { [self] (user) in
                    self.currentUserData = user
                    navigationItem.title = "\(user.firstname) \(user.lastname)"
                    loadotherUser()
                    
                }
            }
            else{
                UserService.shared.fetchMyModelUser(uid: uid) { [self] (user) in
                    self.currentUserData = user
                    loadotherUser()
                }
            }
           
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func loadotherUser(){
        guard let otherUid = otherUid else {return}
        UserService.shared.checkArtistExist(uid: otherUid) { (result) in
            if result{
                UserService.shared.fetchUser(uid: otherUid) { [self] (user) in
                    self.otherUserData = user
                    loadMessages()
                    
                }
            }
            else{
                UserService.shared.fetchMyModelUser(uid: otherUid) { [self] (user) in
                    self.otherUserData = user
                    loadMessages()
                    
                }
            }
           
        }
    }
    func loadMessages() {
        currentUserMEssages(completion: { [self] result in
            let message = MessageModel(dictionary: result)
            messageArray.append(message)
            DispatchQueue.main.async { [self] in
                if messageArray[count].type == "image"{
                    if messageArray[count].from == currentUserID{
                        messages.append(Message(sender: currentUser, messageId: String(count), sentDate: Date().addingTimeInterval(-86400), kind: .text(messageArray[count].message)))
                    }
                    else{
                        messages.append(Message(sender: otherUser, messageId: String(count), sentDate: Date().addingTimeInterval(-86400), kind: .text(messageArray[count].message)))
                    }
                    self.messagesCollectionView.reloadData()
                    count = count + 1
                }
                else{
                    if messageArray[count].from == currentUserID{
                        messages.append(Message(sender: currentUser, messageId: String(count), sentDate: Date().addingTimeInterval(-86400), kind: .text(messageArray[count].message)))
                    }
                    else{
                        messages.append(Message(sender: otherUser, messageId: String(count), sentDate: Date().addingTimeInterval(-86400), kind: .text(messageArray[count].message)))
                    }
                    self.messagesCollectionView.reloadData()
                    count = count + 1
                }
                
            }
            
        })
    }
    
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubbleTail(.bottomRight, .curved)
        
    }
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? #colorLiteral(red: 0.4196078431, green: 0.631372549, blue: 0.7254901961, alpha: 1) : UIColor(red: 230/255, green: 230/255, blue: 235/255, alpha: 1.0)
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func configureMessageCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let date =  Double(messageArray[indexPath.row].time).getDateStringFromUnixTime(dateStyle: .none, timeStyle: .medium)
        
        return NSAttributedString(string: String(date) , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10),NSAttributedString.Key.foregroundColor :UIColor.darkGray ])
        
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
            if message.sender.senderId == "self" {

                avatarView.set(avatar: Avatar(image: #imageLiteral(resourceName: "artist2"), initials: ""))
                
            }else{
                avatarView.set(avatar: Avatar(image: #imageLiteral(resourceName: "like"), initials: ""))
                avatarView.sd_setImage(with:URL(string: otherUserData?.image ?? ""),
                                          placeholderImage: UIImage(named: "placeholder.png"))
                
            }
        }
    
    
    
}
extension ChatViewController {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
        
    }
    
    func didTapCellTopLabel(in cell: MessageCollectionViewCell) {
        print("Top cell label tapped")
    }
    
    func didTapMessageTopLabel(in cell: MessageCollectionViewCell) {
        print("Top message label tapped")
    }
    
    func didTapMessageBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
    func didTapAccessoryView(in cell: MessageCollectionViewCell) {
        print("Accessory view tapped")
    }
    
    
}


extension ChatViewController : InputBarAccessoryViewDelegate  {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        // Here we can parse for which substrings were autocompleted
        let attributedText = messageInputBar.inputTextView.attributedText!
        let range = NSRange(location: 0, length: attributedText.length)
        attributedText.enumerateAttribute(.autocompleted, in: range, options: []) { (_, range, _) in
            
            let substring = attributedText.attributedSubstring(from: range)
            let context = substring.attribute(.autocompletedContext, at: 0, effectiveRange: nil)
            print("Autocompleted: `", substring, "` with context: ", context ?? [])
        }
        
        let components = inputBar.inputTextView.text
        print(components!)
        messageInputBar.invalidatePlugins()
        
        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "Sending..."
        DispatchQueue.global(qos: .default).async { [self] in
            // fake send request task
            //            sleep(1)
            sendMessage(message: components!) { (error, ref) -> (Void) in
                if error == nil {
                    receiveMessage(message: components!) { (error, ref) -> (Void) in
                        if error == nil{
                            DispatchQueue.main.async { [weak self] in
                                self?.messageInputBar.sendButton.stopAnimating()
                                self?.messageInputBar.inputTextView.placeholder = "write Here"
                                //self?.insertMessages(components)
                                self?.messagesCollectionView.scrollToBottom(animated: true)
                                self?.messageInputBar.inputTextView.text = ""
                            }
                        }
                    }
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    func messageInputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        print("Typing")
    }
    
    func currentUserMEssages(completion: @escaping ([String: AnyObject])->Void) {
        guard let uid = currentUserID else { return }
        REF_messages.child(uid).child(otherUid!).observe(.value) { [self] (snapshot) in
            count = 0
            messages.removeAll()
            messageArray.removeAll()
            for snap in snapshot.children {
                let messageSnap = snap as! DataSnapshot
                currentUsermessageDict = messageSnap.value as? [String : AnyObject]
                completion(currentUsermessageDict!)
                
            }
        }
    }
    
    
    func sendMessage(message : String , completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        
        let value = dictionry(from: currentUserID!, message: message, time: 1625422962288, type: "text", seen: false)
        REF_messages.child(currentUserID!).child(otherUid!).childByAutoId().updateChildValues(value, withCompletionBlock: completion)
    }
    
    func receiveMessage(message : String , completion: @escaping(Error?, DatabaseReference) -> (Void)) {
        let value = dictionry(from: otherUid!, message: message, time: 1625422962288, type: "text", seen: false)
        REF_messages.child(otherUid!).child(currentUserID!).childByAutoId().updateChildValues(value, withCompletionBlock: completion)
    }
    
    
    
    func dictionry(from :  String , message :  String , time : Int , type : String , seen :  Bool) -> [String : Any] {
        return ["from": from,
                "message": message,
                "time": time,
                "type": type,
                "seen": seen,
        ]
        as [String : Any]
    }
    
    
    
    
}
