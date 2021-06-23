//
//  ChatViewController.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//


import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseDatabase

class ChatViewController: MessagesViewController {
    
    let user1 = MockUser(senderId: "1" ,displayName: "Imran")
    let user2 = MockUser(senderId: "2" ,displayName: "Abdullah")
    
    var messages:  [MockMessage] = []
    
    var ref: DatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        ref = Database.database().reference()
        createFirebaseMessage()
        createSampleMessage()

    }
    
    func createSampleMessage(){
        let mes1 = MockMessage(text: "Imran", user: user1,messageId: UUID().uuidString, date: Date())
        let mes2 = MockMessage(text: "Rasheed", user: user2,messageId: UUID().uuidString, date: Date())
        let mes3 = MockMessage(text: "I am Here", user: user1,messageId: UUID().uuidString, date: Date())
        let mes4 = MockMessage(text: "Are you there?", user: user2,messageId: UUID().uuidString, date: Date())
        
        self.messages.append(mes1)
        self.messages.append(mes2)
        self.messages.append(mes3)
        self.messages.append(mes4)
        
        self.messagesCollectionView.reloadData()
    }
        
        
    
    func createFirebaseMessage(){
        
        self.ref.observe(DataEventType.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let name = postDict["name"] as? String,let message = postDict["message"] as? String {
                
                let user = MockUser(senderId: name, displayName: name)
                let mes = MockMessage(text: message, user: user, messageId: UUID().uuidString, date: Date())
                self.messages.append(mes)
                self.messagesCollectionView.reloadData()
                self.messagesCollectionView.scrollToLastItem()
            }
        })
    }
}

extension ChatViewController: MessagesDataSource {
  
    func currentSender() -> SenderType {
        return MockUser(senderId: "1", displayName: "Imran")
    }
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if message.sender.senderId == "2"{
            return UIColor(named: "colorPrimary")!
        }else{
            return UIColor(named: "colorAccent")!
        }
    }
 
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
       // YYYY/MM/dd
        formatter.dateFormat = "HH:mm"
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
       
}

    extension ChatViewController: MessagesLayoutDelegate {
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }

}

extension ChatViewController: MessagesDisplayDelegate {
  
//    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ? .white : .darkText
//    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(tail, .pointedEdge)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let avatar = Avatar(image: #imageLiteral(resourceName: "artist4"), initials: message.sender.displayName)
        avatarView.set(avatar: avatar)
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {

func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
    let messageData = [
        "name" : "Imran",
        "message" : text
    ]
    inputBar.inputTextView.text = ""
    self.ref.childByAutoId().setValue(messageData)

    }
  
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        switch message.sender.senderId{
        case "1":
            return isFromCurrentSender(message: message) ? .white : .darkText
        default:
            return isFromCurrentSender(message: message) ? .white : .darkText
        }
    }
}
