//
//  AccountSettingVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class AccountSettingVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    //MARK:- Varibales
    var settingsData = [SettingsModel]()
    
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        tableView.dataSource = self
        tableView.delegate = self
        registerNib()
        headerView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        headerView.dropShadow()
        loadData()
        setStatusBar()
        hideKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK:-Helper Functions
    
    func registerNib(){
        tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }
    
    
    func loadData() {
        settingsData.append(SettingsModel(detailLbl: "Basic Information", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Bookmarks", iconImg: #imageLiteral(resourceName: "setting") ))
        settingsData.append(SettingsModel(detailLbl: "Your Card", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "My Favourties", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Add Bank", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Subscription Price & Bundle", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Fan & Following", iconImg: #imageLiteral(resourceName: "setting")))
    }
    
    @IBAction func backButtonPressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension AccountSettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.detailLbl.text = settingsData[indexPath.row].detailLbl
        cell.iconImg.image = settingsData[indexPath.row].iconImg
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = EditProfile()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 5:
            self.pushToController(from: .Settings, identifier: .SubscritionsVC )
            
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

