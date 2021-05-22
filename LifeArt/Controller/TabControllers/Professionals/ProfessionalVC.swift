//
//  ProfessionalVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 09/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ProfessionalVC: UIViewController {
 
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var topHeaderView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setStatusBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SuggestedParentCell", bundle: nil), forCellReuseIdentifier: "SuggestedParentCell")
        topHeaderView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        topHeaderView.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func loadData() {
        
    }

}
extension ProfessionalVC :  UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedParentCell", for: indexPath) as! SuggestedParentCell
            cell.collectionView.tag = 0
            cell.cellNumber = 0
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedParentCell", for: indexPath) as! SuggestedParentCell
            cell.cellNumber = 1
            cell.collectionView.tag = 1
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let frame: CGRect = tableView.frame
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        
        let lable = UILabel()
        switch section {
        case 0:
            lable.text = "Suggessted Model"
        default:
            lable.text = "Suggessted Artist"
        }
       
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.width))
        
        
        headerView.addSubview(lable)
        headerView.addSubview(button)
        
        lable.anchor(left: headerView.leftAnchor,  paddingLeft: 20)
        button.anchor(right: headerView.rightAnchor,  paddingRight: 20, width: 100, height: 30)
        button.centerY(inView: headerView)
        lable.centerY(inView: button)
        
        

       return headerView
    }
    
      @objc func pressed(_ sender: UIButton) {
          _ = sender.tag
    
    }

}

