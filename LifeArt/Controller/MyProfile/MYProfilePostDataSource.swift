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
extension MyProfileVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
            cell.artImaeView.sd_setImage(with:URL(string:postArray[row].image),
                                              placeholderImage: UIImage(named: "placeholder.png"))
            cell.discriptionLbl.text = postArray[row].desc
            cell.postUserNameLbl.text = "\(userArray[row].firstname) \(userArray[row].lastname)"
            cell.postTimeLbl.text = postArray[row].time
            cell.followedDate.text = "Followed on \(postArray[row].time)"
            cell.postTimeLbl.text = postArray[row].date
            cell.postProfileImage.sd_setImage(with:URL(string:userArray[row].image),
                                              placeholderImage: UIImage(named: "placeholder.png"))
            cell.postCountryLbl.text = userArray[row].country
            
            cell.selectionStyle = .none
            return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PostCell.CellIndentifier
    }
}
