//
//  SettingsVC.swift
//  LifeArtCopy
//
//  Created by macbook on 4/26/21.
//

import UIKit
import  Firebase
import SwiftyStoreKit
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
        settingsData.append(SettingsModel(detailLbl: "Announcements", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Subscrition", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Terms & Conditions", iconImg: #imageLiteral(resourceName: "setting")))
        settingsData.append(SettingsModel(detailLbl: "Privacy Policy", iconImg: #imageLiteral(resourceName: "setting")))
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
    cell.selectionStyle = .none
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.pushToController(from: .Home, identifier: .EditProfile )
            break
        case 1:
            self.pushToController(from: .Settings, identifier: .NewclassesVC )
            break
        case 2:
            self.pushToController(from: .Home, identifier: .AnnouncementsVC )
            break
        case 6:
            logoutUser()
            break
        case 3 :
            InAppPurchase()
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

    
    func InAppPurchase() {
        SwiftyStoreKit.purchaseProduct("com.lifeArt.app.sub", quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                print(purchase.productId)
                addLottieAnimation(string: "success", view: self.view)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                    showError(viewController: self)
                case .clientInvalid: print("Not allowed to make the payment")
                    showError(viewController: self)
                case .paymentCancelled: break
                case .paymentInvalid:
                    showError(viewController: self)
                    print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                    showError(viewController: self)
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                    showError(viewController: self)
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                    showError(viewController: self)
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                    showError(viewController: self)
                default: print((error as NSError).localizedDescription)
                }
            }
        }
    }
}
