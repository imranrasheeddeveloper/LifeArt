//
//  ControllerIdentifier.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit

enum ControllerIdentifier: String {
    case VerifyNumberVC
    case CreateProfileVC
    case TabBar
    case ProfessionalProfileVC
    case AddVC
    case CommentsVC
    case SettingsVC
    case ClassesVC
    case NewclassesVC
    case PesonalDetailVC
    case SubscritionsVC
    case AccountSettingVC
    case LoginVC
    case ForgetPasswordVC
    case EditProfile
    case NotificationVC
    case MyProfileVC
    case CreatePostVC
    case AnnouncementsVC
    case AddAnnouncementsVC
    case SignupVC
    case SuccessVC
    case ErrorVC
    case ChatVC
}

extension UIViewController{
    func pushToController(from name : Storyboard, identifier: ControllerIdentifier) {
        DispatchQueue.main.async { [self] in
            let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
            navigationController?.pushViewController(vc,animated: true)
        }
    
    }
    func pushToRoot(from name : Storyboard, identifier: ControllerIdentifier) {
        DispatchQueue.main.async { [self] in
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        }
        
    }
    
    func imageScreenPush(from name : Storyboard, identifier: ControllerIdentifier) {
        DispatchQueue.main.async { [self] in
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
        }
        
    }
}
