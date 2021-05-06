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
    var arrayOfAnnouncment = [Announcements]()
    var announcements : Announcements?
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
        apiCalling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func sengmentValueCheangeAction(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            datasorce.loadingCell = .AnnouncmentsCell
            delegate.loadingCell = .AnnouncmentsCell
            apiCalling()
            
        }
        else if segment.selectedSegmentIndex == 1{
            datasorce.loadingCell = .NotificationCell
            delegate.loadingCell = .NotificationCell
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }
  
    
    //MARK:- Api Calling
    
    func apiCalling() {
        AnnouncmentService.shared.fetchAnnouncmentServices { [self] (announcements) in
            arrayOfAnnouncment  = announcements
            dump(arrayOfAnnouncment)
            datasorce.arrayOfAnnouncements = arrayOfAnnouncment
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }
}
