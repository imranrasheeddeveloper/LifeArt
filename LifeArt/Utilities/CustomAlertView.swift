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
    
        UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseOut,animations: {
            self.alertView.frame = CGRect(x: self.alertView.frame.origin.x, y: 20, width: self.alertView.frame.width, height: self.alertView.frame.height)


               },completion: nil)
        
    }
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
