//
//  GalleryDelegate.swift
//  LifeArt
//
//  Created by Muhammad Imran on 08/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit

class GalleryDelegate : NSObject , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 220
        default:
            return 450
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PostCell else { return }
//        cell.postProfileImage.showGradientSkeleton()
//        cell.postUserNameLbl.showGradientSkeleton()
//        cell.postTimeLbl.showGradientSkeleton()
//        cell.postCountryLbl.showGradientSkeleton()
//        cell.likesCommentsShare.showGradientSkeleton()
//        cell.artImaeView.showGradientSkeleton()
//        cell.discriptionLbl.showGradientSkeleton()
    }
}
