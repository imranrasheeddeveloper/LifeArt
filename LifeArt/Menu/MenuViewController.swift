//
//  MenuViewController.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    var array = ["Delete Post"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.separatorStyle = .none
        preferredContentSize = CGSize(width: 200, height: tableView.contentSize.height)
        tableView.backgroundColor = .clear
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.dismiss(animated: true, completion: nil)
            menuClick = .deletePost
        default:
            return
        }
        
    }

}
