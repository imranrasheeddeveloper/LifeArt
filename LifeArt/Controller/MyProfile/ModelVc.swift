//
//  ModelVc.swift
//  LifeArt
//
//  Created by Muhammad Imran on 14/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import CoreLocation
class ModelVc: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate  {
    
    //MARK:-OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTF: DesignableUITextField!
    
    //MARK:-VAriables
    var arrayofModel = [UserModel]()
    var locationManager:CLLocationManager!
    var userLocation :CLLocation?
    var isSearch = false
    var fillterArray = [UserModel]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerSetup()
        searchTF.delegate = self
        self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationType.none
        setStatusBar()
        hideKeyboard()
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier:  "SuggestedCell")
        initiateRefreshData()
        
    }
    
    func locationManagerSetup(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationPermission()
        
    }
    func checkLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
                  switch CLLocationManager.authorizationStatus() {
                  case .notDetermined:
                    showLocationAccessAlert()
                  case .restricted, .denied:
                    showLocationAccessAlert()
                  case .authorizedAlways, .authorizedWhenInUse:
                    locationManager.startUpdatingLocation()
                    fetchData()
                  default:
                      print("Invalid AuthorizationStatus")
                  }
              } else {
                 showLocationAccessAlert()
              }
    }
    
    func fetchData() {
        UserService.shared.fetchModels { [self] (user) in
            for (_ , model) in user.enumerated(){
                let coordinate =  CLLocation(latitude: model.lat, longitude: model.lon)
                if userLocation!.distance(from: coordinate) < 50000 {
                    
                    arrayofModel.append(model)
                    
                }
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func searchTFChange(_ sender: UITextField) {
        isSearch = true
        fillterArray.removeAll()
        fillterArray = arrayofModel.filter({
            if  $0.firstname.contains(sender.text!) {
                self.collectionView.reloadData()
                return true
            }
            else{
                return false
            }
            
        })
        if sender.text?.count == 0{
            isSearch = false
            self.collectionView.reloadData()
        }
    }
}

//MARK:- UICollectionView Delegate & DataSource
extension ModelVc :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch == true {
            return fillterArray.count
        }
        else{
            return arrayofModel.count
        }
        
    }
    
    //TODO:- set Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as! SuggestedCell
        if isSearch == true {
            
            cell.profileImage.sd_setImage(with:URL(string:fillterArray[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            
            cell.nameLbl.text = "\(fillterArray[indexPath.row].firstname) \(fillterArray[indexPath.row].lastname)"
        }
        else{
            cell.profileImage.sd_setImage(with:URL(string:arrayofModel[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            cell.profileImage.sd_imageIndicator?.startAnimatingIndicator()
            
            cell.nameLbl.text = "\(arrayofModel[indexPath.row].firstname) \(arrayofModel[indexPath.row].lastname)"
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSearch == true {
            GlobaluserID =  fillterArray[indexPath.row].user
        }else{
            GlobaluserID = arrayofModel[indexPath.row].user
        }
        
        self.parent?.pushToRoot(from: .Home, identifier: .ProfessionalProfileVC)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 300)
    }
    
    
    
}
extension ModelVc {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation  = locations[0] as CLLocation
    }
    
    
    func initiateRefreshData()-> Void {

           let refreshControl = UIRefreshControl()
           let title = NSLocalizedString("Refreshing Models...", comment: "Pull to refresh")
           refreshControl.attributedTitle = NSAttributedString(string: title)
           refreshControl.tintColor = UIColor(named: "colorPrimary")
           refreshControl.addTarget(self, action: #selector(refreshOptions(sender:)),
                                    for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
       }

       @objc private func refreshOptions(sender: UIRefreshControl) {
           arrayofModel.removeAll()
           checkLocationPermission()
           sender.endRefreshing()
       }
}
