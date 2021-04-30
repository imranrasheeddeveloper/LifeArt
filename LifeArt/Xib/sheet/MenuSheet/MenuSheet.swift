//
//  OverlayView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit

class MenuSheet: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var profileLinkview: UIView!
    @IBOutlet weak var moreView: UIView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        slideIdicator.roundCorners(.allCorners, radius: 10)
        setupGestures()
       
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    //MARK:-  Selectors
    
    func setupGestures() {
        let settingTap = UITapGestureRecognizer(target: self, action: #selector(settingTapAction))
        settingView.addGestureRecognizer(settingTap)
        
        let profileTap = UITapGestureRecognizer(target: self, action: #selector(profileTapAction))
        profileLinkview.addGestureRecognizer(profileTap)
        
        let moreTap = UITapGestureRecognizer(target: self, action: #selector(moreTapAction))
        moreView.addGestureRecognizer(moreTap)
    }
    
    
    @objc func settingTapAction(){
        self.pushToRoot(from: .Settings, identifier: .SettingsVC)
    }
    @objc func profileTapAction(){
        
    }
    @objc func moreTapAction(){
        
    }
   
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
