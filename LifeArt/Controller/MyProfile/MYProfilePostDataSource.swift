//
//  MYProfilePostDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import FittedSheets
import SkeletonView
import Firebase
extension MyProfileVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
   
        cell.artImaeView.sd_setImage(with:URL(string:postArray[indexPath.row].postData.image),
                                     placeholderImage: UIImage(named: "placeholder.png"))
        cell.discriptionLbl.text = postArray[indexPath.row].postData.desc
        cell.postUserNameLbl.text =  userName.text!
        cell.postTimeLbl.text = postArray[indexPath.row].postData.time
        
        cell.followedDate.text = (postArray[indexPath.row].postData.medium)
        cell.postTimeLbl.text = "\(postArray[indexPath.row].postData.date)  at \(postArray[indexPath.row].postData.time)"
        cell.postProfileImage.image = profileImage.image
        cell.postCountryLbl.text = (postArray[indexPath.row].postData.size)
        cell.likesLbl.text =  "\(postLikeCount?[indexPath.row] ) Likes"
        cell.viewAllcomments.tag = cell.tag
        cell.likeButton.tag = cell.tag
        cell.viewAllcomments.setTitle("View all \(postNumberOfComments?[indexPath.row] ) Comments", for: .normal)
        cell.totalCommentsLbl.text = "\(postNumberOfComments?[indexPath.row] ) Comments"

        for postLike in postLikesArray{

            if Auth.auth().currentUser!.uid == postLike.data?.userID!{
                    if #available(iOS 13.0, *) {
                        cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        cell.likeButton.tintColor = .red
                    } else {
                        // Fallback on earlier versions
                    }

                }
        }
        cell.selectionStyle = .none
        return cell
    }

}
