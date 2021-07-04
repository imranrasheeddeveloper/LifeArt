//
//  GalleryDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import FittedSheets
import SkeletonView




extension GalleryVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.artImaeView.sd_setImage(with:URL(string:postArray[indexPath.row].postData.image),
                                     placeholderImage: UIImage(named: "placeholder.png"))
        cell.discriptionLbl.text = postArray[indexPath.row].postData.desc
        cell.postUserNameLbl.text = "\(postArray[indexPath.row].userData.fullName) \(postArray[indexPath.row].userData.lastName)"
        cell.postTimeLbl.text = postArray[indexPath.row].postData.time
        
        cell.followedDate.text = (postArray[indexPath.row].postData.medium)
        cell.postTimeLbl.text = "\(postArray[indexPath.row].postData.date)  at \(postArray[indexPath.row].postData.time)"
        cell.postProfileImage.sd_setImage(with:URL(string: postArray[indexPath.row].userData.profileImage),
                                          placeholderImage: UIImage(named: "placeholder.png"))
        cell.postCountryLbl.text = (postArray[indexPath.row].postData.size)
        cell.likesLbl.text =  "\(postArray[indexPath.row].postLikeAndCommentsData.numberOfLikes) Likes"
        cell.viewAllcomments.tag = cell.tag
        cell.likeButton.tag = cell.tag
        cell.viewAllcomments.setTitle("View all \(postArray[indexPath.row].postLikeAndCommentsData.numberOfComments) Comments", for: .normal)
        cell.totalCommentsLbl.text = "\(postArray[indexPath.row].postLikeAndCommentsData.numberOfComments) Comments"
        
        if postArray[indexPath.row].postLikeAndCommentsData.liked {
            if #available(iOS 13.0, *) {
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.likeButton.tintColor = .red
            } else {
                // Fallback on earlier versions
            }
        }
     
        return cell
        
    }
    
    
}

