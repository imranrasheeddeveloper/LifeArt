//
//  EditProfile.swift
//  LifeArt
//
//  Created by Muhammad Imran on 25/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class EditProfile: UIViewController {
    var user : User?
    //MARK:- Delration
    var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UINib(nibName: "EditViewCell", bundle: nil), forCellReuseIdentifier: "EditViewCell")
        return tv
    }()
    
    var navigationBarView : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dropShadow()
        v.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        return v
    }()
    
    var backButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        return button
    }()
    
    var navBarLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Edit Profile"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
     

    //MARK:-VARIBALES
    var data = [Model]()
    
    //MARK:-LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        setupView()
        loadData()
        setStatusBar()
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }
    
    //MARK:- Selector
    
    @objc func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Helper Functions
    func setupView() {
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navBarLabel)
        self.view.addSubview(tableView)
        
        navigationBarView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        
        backButton.anchor( left: navigationBarView.leftAnchor, paddingLeft: 20, width: 24, height: 24)
        backButton.centerY(inView: navigationBarView)
        navBarLabel.anchor(top: navigationBarView.topAnchor  , paddingTop: 10)
        navBarLabel.centerX(inView: navigationBarView)
        navBarLabel.centerY(inView: navBarLabel)
        
        tableView.anchor(top: navigationBarView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
      
    }

    func loadData() {
        data.append(Model(firstLblText: "First Name", secondLblText: "\(user?.firstname ?? "") \(user?.lastname ?? "")", buttonText: "Change"))
        data.append(Model(firstLblText: "Email", secondLblText: user?.email ?? "", buttonText: "Change"))
        data.append(Model(firstLblText: "Bio", secondLblText: user?.bio ?? "", buttonText: "Change"))
        data.append(Model(firstLblText: "Contact", secondLblText: user?.country ?? "", buttonText: "Change"))
        data.append(Model(firstLblText: "Country", secondLblText: user?.country ?? "", buttonText: "Change"))
        data.append(Model(firstLblText: "Website", secondLblText: user?.website ?? "", buttonText: "Change"))

    }
    
}

extension EditProfile: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditViewCell", for: indexPath) as! EditViewCell
        cell.headingLbl.text = data[indexPath.row].firstLblText
        cell.detailLbl.text = data[indexPath.row].secondLblText
        cell.selectionStyle = .none
        if indexPath.row == 2 && indexPath.row == 4 && indexPath.row == 6 && indexPath.row == 7 {
            cell.changeButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 2 {
            let height = cellSize(forWidth: self.view.frame.width, text: data[indexPath.row].secondLblText).height
            return height + 44
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func cellSize(forWidth width: CGFloat, text : String) -> CGSize {
      let measurmentLabel = UILabel()
      measurmentLabel.text = text
      measurmentLabel.numberOfLines = 0
      measurmentLabel.lineBreakMode = .byWordWrapping
      measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
      measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
      return measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
struct Model {
    var firstLblText : String
    var secondLblText : String
    var buttonText : String
}
