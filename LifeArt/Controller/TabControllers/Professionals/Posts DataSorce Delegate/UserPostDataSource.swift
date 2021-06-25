//
//  UserPostDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 20/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

extension  ProfessionalProfileVC : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
        cell.configureCell(post: postArray[row], user: userArray[row], likeCount: postLikeCount[row], totalComments: postNumberOfComments[row], tag: row)
        cell.selectionStyle = .none
        return cell
    }
    
}


