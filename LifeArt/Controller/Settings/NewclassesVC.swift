//
//  NewclassesVC.swift
//  LifeArtCopy
//
//  Created by macbook on 4/26/21.
//

import UIKit

class NewclassesVC: UIViewController {
    @IBOutlet weak var navigationView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        navigationView.dropShadow()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButton(sender  :UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    


}
