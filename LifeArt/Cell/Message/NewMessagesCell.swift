//
//  NewMessagesCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class NewMessagesCell: UITableViewCell {
    
    //MARK: - Properties
    
 
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .customBlackColor
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
     lazy var userFullnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sonic the Hedgehog"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
     lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey! I can be there in 5 seconds"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
     let timeLabel: UILabel = {
        let label = UILabel()
        label.text = String("1h ago")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
 
    
    
    
    //MARK: - Lifecycle
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         configureUI()
         
         addSubview(profileImageView)
         profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
         profileImageView.setDimensions(width: 64, height: 64)
         profileImageView.layer.cornerRadius = 64 / 2
         
         addSubview(userFullnameLabel)
         userFullnameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 85)
              
         addSubview(messageLabel)
         messageLabel.anchor(top: userFullnameLabel.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 85)
         
         addSubview(timeLabel)
         timeLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 15, paddingRight: 20)
        
        
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
    
    //MARK: - API
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    //MARK: - Helper Functions
    
    func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
    }
    
    
    
}

