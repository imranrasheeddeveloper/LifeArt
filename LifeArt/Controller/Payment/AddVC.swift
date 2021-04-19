//
//  AddVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class AddVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func checkButton(_ sender: UIButton) {
    }
    @IBAction func selectButton(_ sender: UIButton) {
    }
    @IBAction func closeTheAddCardVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
