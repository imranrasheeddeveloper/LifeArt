////
////  ChatCell.swift
////  LifeArt
////
////  Created by Muhammad Imran on 27/04/2021.
////  Copyright © 2021 Itrid Technologies. All rights reserved.
////
//
//import UIKit
//import Firebase
//import SDWebImage
//
//protocol ChatCellDelegate: class {
//    func handleProfileImageTapped(_ cell: ChatCell)
//}
//
//class ChatCell: UICollectionViewCell {
//    
//    //MARK: - Properties
//    
//    var message: Message? {
//        didSet {
//            guard let messageText = message?.messageText else {return}
//            textView.text = messageText
//            
//            guard let chatPartnerID = message?.getChatPartnerID() else {return}
//            UserService.shared.fetchUser(uid: chatPartnerID) { (user) in
//                self.profileImageView.sd_setImage(with: URL(string:user.image))
//            }
//        }
//    }
//
//    weak var delegate: ChatCellDelegate?
//    
//    var bubbleWidthAnchor: NSLayoutConstraint?
//    var bubbleViewLeftAnchor: NSLayoutConstraint?
//    var bubbleViewRightAnchor: NSLayoutConstraint?
//    
//    let bubbleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .progressLayerColor
//        view.layer.cornerRadius = 16
//        view.layer.masksToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    let textView: UITextView = {
//        let view = UITextView()
//        view.text = "Test"
//        view.font = UIFont.systemFont(ofSize: 16)
//        view.backgroundColor = .clear
//        view.textColor = .white
//        view.isEditable = false
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    lazy var profileImageView: UIImageView = {
//        let view = UIImageView()
//        view.backgroundColor = .customBlackColor
//        view.contentMode = .scaleAspectFill
//        view.clipsToBounds = true
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleExpertProfileTapped))
//        view.addGestureRecognizer(tap)
//        view.isUserInteractionEnabled = true
//        
//        return view
//    }()
//    
//    //MARK: - Lifecycle
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(bubbleView)
//        addSubview(textView)
//        
//        addSubview(profileImageView)
//        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4, width: 32, height: 32)
//        profileImageView.layer.cornerRadius = 32 / 2
//       
//        //bubbleview message cell right anchor
//        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
//        bubbleViewRightAnchor?.isActive = true
//        
//        //bubbleview message cell left anchor
//        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8)
//        bubbleViewLeftAnchor?.isActive = false
//        
//        //bubbleview message cell width and top anchor
//        bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
//        bubbleWidthAnchor?.isActive = true
//        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//        
//        //bubble view text view
//        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
//        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
//        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
//        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - API
//    
//    
//    
//    
//    
//    //MARK: - Selectors
//    
//    @objc func handleExpertProfileTapped() {
//        delegate?.handleProfileImageTapped(self)
//         
//    }
//    
//    
//    
//    //MARK: - Helper Functions
//    
//
//
//}
//
//
