//
//  NotificationVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var headerView: UIView!
    
    //MARK:-Variables
    var arrayOfAnnouncment = [Announcements]()
    var arrayOfNotification = [NotificationModel]()
    var announcements : Announcements?
    var notification : NotificationModel?
    let datasorce = NotificationDataSource()
    let delegate = NotificationDelegate()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        tabelView.dataSource =  datasorce
        tabelView.delegate = delegate
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
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
            apiCallingForNotifications()
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
    
    func apiCallingForNotifications() {
        AnnouncmentService.shared.fetchNotifications { [self] (noti) in
            arrayOfNotification  = noti
            dump(arrayOfNotification)
            datasorce.arrayOfNotification = arrayOfNotification
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }
    
}
