//
//  SceneDelegate.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//

import UIKit
import Firebase
import FirebaseAuth
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let winScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: winScene)
        if Auth.auth().currentUser != nil {
            let storyboard =  UIStoryboard(name: "Home", bundle: nil)
            let startMainVC = storyboard.instantiateViewController(withIdentifier: "TabBar")
            let nc = UINavigationController(rootViewController: startMainVC)
            win.rootViewController = nc
            win.makeKeyAndVisible()
        }
        else
        {
            let storyboard =  UIStoryboard(name: "Main", bundle: nil)
            let startSignUPVC = storyboard.instantiateViewController(withIdentifier: "SignupVC")
            let nc = UINavigationController(rootViewController: startSignUPVC)
            win.rootViewController = nc
            win.makeKeyAndVisible()
        }
        window = win
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
  
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
      
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}


