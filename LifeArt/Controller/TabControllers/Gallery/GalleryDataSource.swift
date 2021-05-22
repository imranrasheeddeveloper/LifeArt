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
        print(postArray.count)
        print(userArray.count)
        return postArray.count  + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryHeaderCell", for: indexPath) as! GalleryHeaderCell
            cell.selectionStyle = .none
            cell.fullNameLbl.text = ("\(KeychainWrapper.standard.string(forKey: "firstname") ?? "Jon") \(KeychainWrapper.standard.string(forKey: "lastname") ?? "Doe")")
            return cell
        default:
            let row = indexPath.row - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.delegate = self
            cell.artImaeView.sd_setImage(with:URL(string:postArray[row].postData.image),
                                              placeholderImage: UIImage(named: "placeholder.png"))
            cell.discriptionLbl.text = postArray[row].postData.desc
            cell.postUserNameLbl.text = "\(userArray[row].firstname) \(userArray[row].lastname)"
            cell.postTimeLbl.text = postArray[row].postData.time
            cell.followedDate.text = "Followed on \(postArray[row].postData.time)"
            cell.postTimeLbl.text = postArray[row].postData.date
            cell.postProfileImage.sd_setImage(with:URL(string:userArray[row].image),
                                              placeholderImage: UIImage(named: "placeholder.png"))
            cell.postCountryLbl.text = userArray[row].country
            cell.viewAllcomments.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        }
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PostCell.CellIndentifier
    }
    
    
    
    
    
}

