//
//  CustomAlertView.swift
//  CheckMe
//
//  Created by Muhammad Imran on 05/04/2021.
//

import UIKit

class CustomAlertView: UIViewController {

    
    @IBOutlet weak var alertView : UIView!
    @IBOutlet weak var centerVeticalyConstrains : NSLayoutConstraint!
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
    
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
