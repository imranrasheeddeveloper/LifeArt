//
//  AddAnnouncementsVC.swift
//  LifeArt
//
//  Created by Sohaib Ahmed Khan on 17/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import CoreLocation
import MaterialComponents

class AddAnnouncementsVC: UIViewController {
   
    //MARK:_ OUTLETS
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var postTitleTF: MDCOutlinedTextField!
    @IBOutlet weak var descriptionTF: MDCOutlinedTextField!
    @IBOutlet weak var salaryTF: MDCOutlinedTextField!
    @IBOutlet weak var instituteNameTF: MDCOutlinedTextField!
    
    //MARK:- Variables
    var locationManager:CLLocationManager!
    var lat : Double?
    var lng : Double?
    
    //MARK:-LiFECYCles
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.dropShadow()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        setStatusBar()
        hideKeyboard()
        setupTextfields()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupTextfields(){
        
        postTitleTF.label.text = "Post Title"
        salaryTF.label.text = "Salary"
        instituteNameTF.label.text  = "Institute Name"
        descriptionTF.label.text = "Description"
        
        descriptionTF.sizeToFit()
        salaryTF.sizeToFit()
        postTitleTF.sizeToFit()
        instituteNameTF.sizeToFit()
        
        postTitleTF.containerRadius = 10
        instituteNameTF.containerRadius  = 10
        salaryTF.containerRadius = 10
        descriptionTF.containerRadius = 20
        
        descriptionTF.verticalDensity = 80
        salaryTF.verticalDensity = 40
        postTitleTF.verticalDensity = 40
        instituteNameTF.verticalDensity = 40
    }
    
    
    //MARK:-
    func locationManagerSetup(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func makeAnnouncementBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func dateTime() {
        let date = currentDate()
        let time = currentTime()
    }
    
}
extension AddAnnouncementsVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        lat =   userLocation.coordinate.latitude
        lng =    userLocation.coordinate.longitude
    }
}
