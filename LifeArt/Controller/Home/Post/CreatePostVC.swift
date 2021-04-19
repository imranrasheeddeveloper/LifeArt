//
//  CreatePostVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class CreatePostVC: UIViewController {
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var NavigationBarView : UIView!
    @IBOutlet weak var bottomView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        NavigationBarView.dropShadow()
        NavigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        textView.layer.cornerRadius = 10
        bottomView.dropShadow()
        textView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            textView.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            textView.layer.borderColor = UIColor.gray.cgColor
        }
        // Do any additional setup after loading the view.
    }

}
