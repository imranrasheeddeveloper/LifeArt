//
//  ErrorVC.swift
//  LifeArt
//
//  Created by Sohaib Ahmed Khan on 26/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ErrorVC: UIViewController {
    @IBOutlet weak var alertView : UIView!
    @IBOutlet weak var errorAnmationView : UIView!
    @IBOutlet weak var errorLbl : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addLottieAnimationOnAlert(string: "error", view: errorAnmationView)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeLottieAnimation()
    }
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    @IBAction func onTapOkButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
