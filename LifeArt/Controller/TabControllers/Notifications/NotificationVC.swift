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
         tabelView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tabelView.dataSource =  datasorce
         tabelView.delegate = delegate
         headerView.dropShadow()
         headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
          apiCallingForNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    func apiCallingForNotifications() {
        AnnouncmentService.shared.fetchNotifications { [self] (noti) in
            arrayOfNotification  = noti
            dump(arrayOfNotification)
            datasorce.arrayOfNotification = arrayOfNotification
            if arrayOfNotification.count == 0 {
                addLottieAnimation(string: "notificationEmpty", view: self.view)
            }
            else{
                removeLottieAnimation()
            }
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
        }
    }
    
    
    
    //MARK:-Actions
    
    @IBAction func backBtnActions(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
