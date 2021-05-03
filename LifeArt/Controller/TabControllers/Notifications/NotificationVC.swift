//
//  NotificationVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    let datasorce = NotificationDataSource()
    let delegate = NotificationDelegate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        tabelView.dataSource =  datasorce
        tabelView.delegate = delegate
        tabelView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tabelView.register(UINib(nibName: "AnnouncmentsCell", bundle: nil), forCellReuseIdentifier: "AnnouncmentsCell")
        datasorce.loadingCell = .AnnouncmentsCell
        delegate.loadingCell = .AnnouncmentsCell
        
    }
    @IBAction func sengmentValueCheangeAction(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            datasorce.loadingCell = .AnnouncmentsCell
            delegate.loadingCell = .AnnouncmentsCell
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
            
        }
        else if segment.selectedSegmentIndex == 1{
            datasorce.loadingCell = .NotificationCell
            delegate.loadingCell = .NotificationCell
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }
  
    
}
