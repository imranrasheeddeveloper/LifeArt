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
    var arrayOfAnnouncements = [Announcements]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAnnouncements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch loadingCell {
        case .AnnouncmentsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: loadCell.AnnouncmentsCell.rawValue , for: indexPath) as! AnnouncmentsCell
            cell.time.text = arrayOfAnnouncements[indexPath.row].time
            cell.insituteName.text = arrayOfAnnouncements[indexPath.row].name
            cell.salaryLbl.text = arrayOfAnnouncements[indexPath.row].salary
            cell.titleLbl.text = arrayOfAnnouncements[indexPath.row].title
            cell.titleOfType.text = arrayOfAnnouncements[indexPath.row].title
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
