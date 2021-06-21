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
extension GalleryVC : UITableViewDataSource{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.delegate = self
        
         cell.artImaeView.sd_setImage(with:URL(string:postArray[indexPath.row].postData.image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
         cell.artImaeView.sd_imageIndicator?.startAnimatingIndicator()
        cell.discriptionLbl.text = postArray[indexPath.row].postData.desc
        cell.postUserNameLbl.text = "\(userArray[indexPath.row].firstname) \(userArray[indexPath.row].lastname)"
        cell.postTimeLbl.text = postArray[indexPath.row].postData.time

        cell.followedDate.text = "Followed on \(postArray[indexPath.row].postData.time)"
        cell.postTimeLbl.text = postArray[indexPath.row].postData.date
        cell.postProfileImage.sd_setImage(with:URL(string:userArray[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
    
        cell.postCountryLbl.text = userArray[indexPath.row].country
        cell.likesLbl.text =  "\(postLikeCount[indexPath.row] ?? "0") Likes"
        cell.viewAllcomments.tag = cell.tag
        cell.likeButton.tag = cell.tag
        cell.viewAllcomments.setTitle("View all \(postNumberOfComments[indexPath.row] ?? "0") Comments", for: .normal)
         cell.totalCommentsLbl.text = "\(postNumberOfComments[indexPath.row] ?? "0") Comments"
        
        
        for postLike in postLikesArray{
            if postArray[indexPath.row].key == postLike.postID {
                if userArray[indexPath.row].uid == postLike.data?.userID{
                    if #available(iOS 13.0, *) {
                        cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        cell.likeButton.tintColor = .red
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            }
        }
    
            return cell
        
}
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PostCell.CellIndentifier
    }
}

