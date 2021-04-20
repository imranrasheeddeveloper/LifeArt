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
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestedParentCell", for: indexPath) as! SuggestedParentCell
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      
     let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
      header.textLabel!.textColor = .black
      
      let headerLabelFont: UIFont = header.textLabel!.font

      var selectButton: UIButton? = nil
    
      for i in 0..<view.subviews.count {
        if view.subviews[i] is UIButton {
          let tempButton = view.subviews[i] as? UIButton
          if (tempButton?.currentTitle != "") {
            selectButton = view.subviews[i] as? UIButton
          }
        }
      }
      
      // No buttons exist, create new ones
      if selectButton == nil {
        selectButton = UIButton(type: .system)
        header.addSubview(selectButton!)
      }
      
      // Configure buttons
      selectButton?.frame = CGRect(x: view.frame.size.width - 85, y: view.frame.size.height - 28, width: 77, height: 26)
      selectButton?.tag = section
      selectButton?.setTitle("View All", for: .normal)
      selectButton?.titleLabel?.font = UIFont(descriptor: headerLabelFont.fontDescriptor, size: 11)
      selectButton?.contentHorizontalAlignment = .right;
      selectButton?.setTitleColor(self.view.tintColor, for: .normal)
      selectButton?.addTarget(self, action: #selector(self.selectAllInSection), for: .touchUpInside)
      
    }
    
      @objc func selectAllInSection(_ sender: UIButton) {
          _ = sender.tag
      // change button title to reflect status
      if (sender.titleLabel?.text == "SELECT ALL") {
        sender.setTitle("SELECT NONE", for: .normal)
      } else {
        sender.setTitle("SELECT ALL", for: .normal)
      }
    }

}

