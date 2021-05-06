//
//  SettingsVC.swift
//  LifeArtCopy
//
//  Created by macbook on 4/26/21.
//

import UIKit
import  Firebase

struct SettingsModel {
var detailLbl : String
var iconImg : UIImage
}

class SettingsVC: UIViewController {
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
        settingsData.append(SettingsModel(detailLbl: "Account Settings", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Classes", iconImg: #imageLiteral(resourceName: "setting") ))
        settingsData.append(SettingsModel(detailLbl: "Language", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Terms and Conditions", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Privacy Policy", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Help & Support", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "LogOut", iconImg: #imageLiteral(resourceName: "setting")))
    }
    
    @IBAction func backButtonPressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }


}

//MARK:-Extensions DataSource,Delegate

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingsData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
    cell.detailLbl.text = settingsData[indexPath.row].detailLbl
    cell.iconImg.image = settingsData[indexPath.row].iconImg
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.pushToController(from: .Settings, identifier: .AccountSettingVC )
        case 1:
            self.pushToController(from: .Settings, identifier: .ClassesVC )
        case 6:
            logoutUser()
        default:
            break
        }
    }
    
    func logoutUser() {
        // call from any screen
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        self.pushToRoot(from: .main, identifier: .LoginVC)
        
    }

}
