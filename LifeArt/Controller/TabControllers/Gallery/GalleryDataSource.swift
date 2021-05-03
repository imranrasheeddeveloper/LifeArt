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
extension GalleryVC : SkeletonTableViewDataSource{
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryHeaderCell", for: indexPath) as! GalleryHeaderCell
            cell.selectionStyle = .none
            cell.fullNameLbl.text = ("\(KeychainWrapper.standard.string(forKey: "firstname") ?? "Jon") \(KeychainWrapper.standard.string(forKey: "lastname") ?? "Doe")")
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
            cell.delegate = self
            cell.postProfileImage.sd_setImage(with:URL(string:postArray[indexPath.row].image!),
                                              placeholderImage: UIImage(named: "placeholder.png"))
            cell.discriptionLbl.text = postArray[indexPath.row].desc
            cell.postUserNameLbl.text = postArray[indexPath.row].us
            cell.selectionStyle = .none
            return cell
        }
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PostCell.CellIndentifier
    }
    
    
    
    
    
}

