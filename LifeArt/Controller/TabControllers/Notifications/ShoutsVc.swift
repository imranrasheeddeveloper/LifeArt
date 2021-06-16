//
//  ShoutsVc.swift
//  LifeArt
//
//  Created by Sohaib Ahmed Khan on 16/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ShoutsVc: UIViewController {

    //MARK:-OUtLETS
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var headerView: UIView!

    
    //MARKL:-
    var arrayOfAnnouncment = [Announcements]()
    var announcements : Announcements?
    var notification : NotificationModel?
    let datasorce = NotificationDataSource()
    let delegate = NotificationDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        tabelView.dataSource =  self
        tabelView.delegate = self
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        tabelView.register(UINib(nibName: "AnnouncmentsCell", bundle: nil), forCellReuseIdentifier: "AnnouncmentsCell")
//        tabelView.register(UINib(nibName: "AnnouncmentsCell", bundle: nil),   forCellReuseIdentifier: "AnnouncmentsCell")
//        datasorce.loadingCell = .AnnouncmentsCell
//        delegate.loadingCell = .AnnouncmentsCell
        apiCalling()

    }
    

    
    //MARK:-APICALLING
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
extension ShoutsVc: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfAnnouncment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnouncmentsCell", for: indexPath) as! AnnouncmentsCell
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}
