//
//  SubscriptionAlertVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class SubscriptionAlertVC: UIViewController {

    @IBOutlet weak var alertView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        animateView()
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })

    }
    @IBAction func addPaymentMethod(_ sender: UIButton) {
        self.pushToRoot(from: .Payment, identifier: .AddVC)
        
    }
    @IBAction func closeAlert(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
