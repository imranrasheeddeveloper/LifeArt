//
//  ProfessionalVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 09/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ProfessionalVC: UIViewController {
 
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var topHeaderView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setStatusBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SuggestedParentCell", bundle: nil), forCellReuseIdentifier: "SuggestedParentCell")
        topHeaderView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        topHeaderView.dropShadow()
    }
    
    func loadData() {
        
    }

}
extension ProfessionalVC :  UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedParentCell", for: indexPath) as! SuggestedParentCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }

}

