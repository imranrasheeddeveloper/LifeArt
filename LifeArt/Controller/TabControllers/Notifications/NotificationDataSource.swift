//
//  NotificationDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class NotificationDataSource: NSObject ,UITableViewDataSource{
    var loadingCell  :  loadCell!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch loadingCell {
        case .AnnouncmentsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: loadCell.AnnouncmentsCell.rawValue , for: indexPath)
            cell.selectionStyle = .none
            return cell
            
        case .NotificationCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: loadCell.NotificationCell.rawValue , for: indexPath)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
}


enum loadCell : String{
    case AnnouncmentsCell
    case NotificationCell
}
