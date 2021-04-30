//
//  MenuPresentationController.swift
//  LifeArt
//
//  Created by Muhammad Imran on 27/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit
class MenuPresentationController: UIPresentationController {

    var blurEffectView :  UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
  var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    var isBottom: Bool {
        if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0 {
            return true
        }
        return false
    }
  var sheetHeight = 280
  
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    //let blurEffect = UIBlurEffect(style: .regular)
     // blurEffectView = UIVisualEffectView(effect: blurEffect)
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
      tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      self.blurEffectView.isUserInteractionEnabled = true
      self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)

  }
  
  override var frameOfPresentedViewInContainerView: CGRect {
    
    if isBottom {
        let bounds = presentingViewController.view.frame
        let size = CGSize(width: self.containerView!.bounds.width, height: 300)
        let origin = CGPoint(x: 0, y: bounds.origin.y - (300 - UIScreen.main.bounds.height
        ))
        print(bounds.origin.y - (UIScreen.main.bounds.height - 300))
                return CGRect(origin: origin, size: size)
    }
    else{
        let bounds = presentingViewController.view.frame
        let size = CGSize(width: self.containerView!.bounds.width, height: 280)
        let origin = CGPoint(x: 0, y: bounds.origin.y - (280 - UIScreen.main.bounds.height
        ))
        print(bounds.origin.y - (UIScreen.main.bounds.height - 280))
                return CGRect(origin: origin, size: size)
    }
  
  }

  override func presentationTransitionWillBegin() {
    self.blurEffectView.alpha = 0.7
      self.containerView?.addSubview(blurEffectView)
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
  }
  
  override func dismissalTransitionWillBegin() {
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
        self.blurEffectView.alpha = 0
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in
          self.blurEffectView.removeFromSuperview()
      })
  }
  
  override func containerViewWillLayoutSubviews() {
      super.containerViewWillLayoutSubviews()
    presentedView!.roundCorners([.topLeft, .topRight], radius: 0)
  }

  override func containerViewDidLayoutSubviews() {
      super.containerViewDidLayoutSubviews()
      presentedView?.frame = frameOfPresentedViewInContainerView
      blurEffectView.frame = containerView!.bounds
  }

  @objc func dismissController(){
      self.presentedViewController.dismiss(animated: true, completion: nil)
  }
    

}

