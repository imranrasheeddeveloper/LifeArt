//
//  AppDelegate+Extension.swift
//  LifeArt
//
//  Created by Muhammad Imran on 02/05/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import  UIKit
extension AppDelegate{
    func loadindIndicator(title : String) {
        if let keyWindow = UIWindow.key {
            alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            if #available(iOS 13.0, *) {
                loadingIndicator.style = UIActivityIndicatorView.Style.large
            }
            else if #available(iOS 12.0, *) {
                loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
                loadingIndicator.color = UIColor.gray
            }
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            DispatchQueue.main.async {
                keyWindow.rootViewController?.present(self.alert, animated: true, completion: nil)
            }
        }
    }
    func removeLoadIndIndicator(){
        DispatchQueue.main.async { [self] in
            self.alert.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
