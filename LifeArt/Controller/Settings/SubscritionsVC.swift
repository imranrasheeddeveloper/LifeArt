//
//  SubscritionsVC.swift
//  LifeArtCopy
//
//  Created by macbook on 4/27/21.
//

import UIKit

class SubscritionsVC: UIViewController {

    @IBOutlet weak var navigationView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         setStatusBar()
        hideKeyboard()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        navigationView.dropShadow()
    }
    
    @IBAction func backButtonPressed(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }


}
