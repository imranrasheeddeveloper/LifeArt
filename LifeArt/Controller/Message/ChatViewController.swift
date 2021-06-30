//
//  ChatVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 06/07/2019.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import MessageKit
import InputBarAccessoryView

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
    
    let currentUser = Sender(senderId: "self", displayName: "Imran")
    let otherUser = Sender(senderId: "other", displayName: "Bilal")
    var messages = [MessageType]()
    
    
    private let navBarView : UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let backButton : UIButton = {
       let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            b.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        } else {
           
        }
        return b
    }()
    
    private let userImageView : UIImageView = {
       let userImageView = UIImageView()
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        return userImageView
    }()
    
    private let userName : UILabel = {
       let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    
    func setupConstrains() {
        
        self.view.addSubview(navBarView)
        
        navBarView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0 , paddingRight: 0 , height: 80)
        self.view.backgroundColor = .white
        navBarView.dropShadow()
        navBarView.layer.borderWidth = 1
        self.navBarView.addSubview(backButton)

        backButton.anchor(top: self.view.topAnchor , left: self.navBarView.leftAnchor, paddingTop: 40,  paddingLeft: 10, width: 22, height: 22)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        self.messagesCollectionView.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 70, right: 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        
//          setCrossButton()
        setStatusBar()
          super.viewDidLoad()
        navigationItem.title = "Waqar Shokat"
       // setupConstrains()
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.setMessageIncomingAvatarSize(.zero)
            layout.setMessageOutgoingAvatarSize(.zero)
        }
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "6", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "7", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "8", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
        
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
    
//    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
//        return 20
//    }
    
    func configureMessageCollectionView() {

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self

        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false

//        messagesCollectionView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {

             return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         }

//         func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//             let name = message.sender.displayName
//             return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
//         }

         func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
            // let df = DateFormatter()
//             df.dateFormat = "hh:mm"
//             let dateString = df.string(from: message.sentDate)
//            return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
             return NSAttributedString(string: "Read 21:21", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10),NSAttributedString.Key.foregroundColor :UIColor.darkGray ])
            
         }
    
//    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
//
//        return NSAttributedString(string: "read", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10),NSAttributedString.Key.foregroundColor :UIColor.darkGray ])
//           }
    
    
    
    
    

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

extension ChatViewController{
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)

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
        
        messages.append(Message(sender: currentUser, messageId: "8", sentDate: Date().addingTimeInterval(-86400), kind: .text(components!)))
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
        }
//           messageInputBar.inputTextView.text = String()
           messageInputBar.invalidatePlugins()
    
           // Send button activity animation
           messageInputBar.sendButton.startAnimating()
           messageInputBar.inputTextView.placeholder = "Sending..."
           DispatchQueue.global(qos: .default).async {
               // fake send request task
               sleep(1)
               DispatchQueue.main.async { [weak self] in
                   self?.messageInputBar.sendButton.stopAnimating()
                   self?.messageInputBar.inputTextView.placeholder = "Aa"
                   //self?.insertMessages(components)
                   self?.messagesCollectionView.scrollToBottom(animated: true)
               }
           }
       }
    func messageInputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
           print("Typing")
    }
    

}

    
    
    
   
