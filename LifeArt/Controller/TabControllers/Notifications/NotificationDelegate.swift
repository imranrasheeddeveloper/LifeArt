//
//  NotificationDelegate.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class NotificationDelegate: NSObject , UITableViewDelegate {
    var loadingCell : loadCell!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch loadingCell {
        case .AnnouncmentsCell:
            return 210
        case .NotificationCell:
            return 100
        case .none:
           return  210
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
