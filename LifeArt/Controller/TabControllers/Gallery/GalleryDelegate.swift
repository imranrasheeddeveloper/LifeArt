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
        return 450
    }
}
