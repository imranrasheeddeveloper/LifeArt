//
//  CustomNavigationController.swift
//  LifeArt
//
//  Created by Muhammad Imran on 04/07/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit

//class CustomNavigationController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let color = UIColor(red: 81 / 255, green: 155 / 255, blue: 22 / 255, alpha: 1.0)
//        self.navigationController?.navigationBar.barTintColor = color
//
//        let image = UIImage(named: "logo")
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFit
//        navigationItem.titleView = imageView
//    }
//
//    private func imageView(imageName: String) -> UIImageView {
//        let logo = UIImage(named: imageName)
//        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.image = logo
//        logoImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
//        logoImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        return logoImageView
//    }
//
//    func barImageView(imageName: String) -> UIBarButtonItem {
//        return UIBarButtonItem(customView: imageView(imageName: imageName))
//    }
//
//    func barButton(imageName: String, selector: Selector) -> UIBarButtonItem {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: imageName), for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        button.addTarget(self, action: selector, for: .touchUpInside)
//        return UIBarButtonItem(customView: button)
//    }
//
//}
