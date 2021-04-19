//
//  SignupVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit

class SignupVC: UIViewController {

    //MARK:-Outlets
    
    var heightConstraint:NSLayoutConstraint!
    public fileprivate(set) var blackOverlay: UIControl = UIControl()
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        hideKeyboard()
        setStatusBar()
    }
    
      func showSheet() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
   
    //MARK:- Actions
    
    @IBAction func signUPAction(_ sender : UIButton){
        self.pushToController(from: .main, identifier: .VerifyNumberVC)
    }
    @IBAction func whoAreYou(_ sender: UITextField) {
        showSheet()
    }
}
extension SignupVC:  UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
