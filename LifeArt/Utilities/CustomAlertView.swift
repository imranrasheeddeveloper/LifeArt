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
        print(centerVeticalyConstrains.constant)
        DispatchQueue.main.async { [self] in
            UIView.animate(withDuration: 0.2, delay: 1,options: UIView.AnimationOptions.curveEaseOut,animations: {
                self.centerVeticalyConstrains.constant = 0
                   },completion: nil)
        }
        
    }
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
