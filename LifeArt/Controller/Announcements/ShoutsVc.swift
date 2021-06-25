//
//  ShoutsVc.swift
//  LifeArt
//
//  Created by Sohaib Ahmed Khan on 16/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import CoreLocation
class ShoutsVc: UIViewController, CLLocationManagerDelegate {

    //MARK:-OUtLETS
    @IBOutlet weak var tabelView : UITableView!
    @IBOutlet weak var headerView: UIView!

    
    //MARKL:-
    var arrayOfAnnouncment = [Announcements]()
    var announcements : Announcements?
    var notification : NotificationModel?
    let datasorce = NotificationDataSource()
    let delegate = NotificationDelegate()
    var userLocation :CLLocation?
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        locationManagerSetup()
        tabelView.isHidden = true
        addLottieAnimation(string: "noannouncement", view: self.view)
        tabelView.dataSource =  self
        tabelView.delegate = self
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        tabelView.register(UINib(nibName: "AnnouncmentsCell", bundle: nil), forCellReuseIdentifier: "AnnouncmentsCell")
        apiCalling()

    }
    
    //MARK:- Location Servieces
    func locationManagerSetup(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation  = locations[0] as CLLocation
    }
    
    //MARK:-APICALLING
    func apiCalling() {
            AnnouncmentService.shared.fetchAnnouncmentServices { [self] (announcements) in
                for an in announcements{
                    let coordinate =  CLLocation(latitude: an.lat, longitude: an.lon)
                    if userLocation!.distance(from: coordinate) < 50000 {
                        arrayOfAnnouncment.append(an)
                    }
                }
                

                if arrayOfAnnouncment.count != 0{
                    removeLottieAnimation()
                    tabelView.isHidden = false
                    DispatchQueue.main.async {
                        self.tabelView.reloadData()
                    }
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
        cell.desLbl.text = arrayOfAnnouncment[indexPath.row].des
        cell.insituteName.text = arrayOfAnnouncment[indexPath.row].name
        cell.priceLbl.text = arrayOfAnnouncment[indexPath.row].salary
        cell.time.text = arrayOfAnnouncment[indexPath.row].time
        cell.titleLbl.text = arrayOfAnnouncment[indexPath.row].title
        cell.salaryLbl.text = arrayOfAnnouncment[indexPath.row].salary
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
}
