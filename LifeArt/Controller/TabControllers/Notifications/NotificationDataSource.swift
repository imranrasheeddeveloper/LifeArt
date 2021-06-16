//
//  NotificationDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class NotificationDataSource: NSObject ,UITableViewDataSource{
    
    var arrayOfNotification = [NotificationModel]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell" , for: indexPath) as! NotificationCell
            cell.discriptionText.text = arrayOfNotification[indexPath.row].post
            cell.dateTimeText.text = arrayOfNotification[indexPath.row].date
            cell.selectionStyle = .none
            return cell
    }

}
