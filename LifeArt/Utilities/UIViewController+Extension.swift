//
//  Extension + UIViewController.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setStatusBar() {
        let tag = 12321
        if let taggedView = self.view.viewWithTag(tag){
            taggedView.removeFromSuperview()
        }
        let overView = UIView()
        overView.frame = UIApplication.shared.statusBarFrame
        overView.backgroundColor = UIColor(named: "colorPrimary")
        overView.tag = tag
        self.view.addSubview(overView)
    }
    
    
    ///// Bottomsheet
    
    func add(_ child: UIViewController) {
        // First, add the view of the child to the view of the parent
        addChild(child)
        
        // Then, add the child to the parent
        view.addSubview(child.view)
        
        // Finally, notify the child that it was moved to a parent
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        // First, notify the child that it’s about to be removed
        willMove(toParent: nil)
        
        // Then, remove the child from its parent
        removeFromParent()
        
        // Finally, remove the child’s view from the parent’s
        view.removeFromSuperview()
    }
    
    
}

extension UINavigationController
{
    override open var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
     }
 }
extension UIViewController {
    
    func presentAlertController(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func shouldPresentLoadingView(_ present: Bool, message: String? = nil){
        if present {
            let loadingView = UIView()
            loadingView.frame = self.view.frame //the view will take up whole screen
            loadingView.backgroundColor = .black
            loadingView.alpha = 0
            loadingView.tag = 1
            
            let indicator = UIActivityIndicatorView() //makes the circular 'loading' indicator
            if #available(iOS 13.0, *){
                indicator.style = .large
            }
            indicator.style = .gray
            indicator.center = view.center
            indicator.color = .white
            
            let label = UILabel()
            label.text = message
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .white
            label.alpha = 0.87
            label.textAlignment = .center
            
            view.addSubview(loadingView)
            loadingView.addSubview(indicator)
            loadingView.addSubview(label)
            
            label.centerX(inView: view)
            label.anchor(top: indicator.bottomAnchor, paddingTop: 35)
            
            indicator.startAnimating() //makes the 'loading' animation
            
            UIView.animate(withDuration: 0.3) {
                loadingView.alpha = 0.7
            }
            
          
        } else {
            view.subviews.forEach { (subview) in
                if subview.tag == 1 {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0
                    }) { (_) in
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
//    func PaymentAlert() {
//        let vc = EditProfile()
//        storyboard?.instantiateViewController(identifier:)
//    }
}
