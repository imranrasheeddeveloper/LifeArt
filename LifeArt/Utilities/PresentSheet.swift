//
//  PresentSheet.swift
//  LifeArt
//
//  Created by Muhammad Imran on 25/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import FittedSheets
//class PresentSheet: NSObject {
func presenttSheet(tag: Int , view : UIView , controller : UIViewController , Identifier :ControllerIdentifier , storyBoard : Storyboard ) {
        var vc = UIViewController()
        let options = SheetOptions(
            useInlineMode: true
        )
    let storyBoard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        if #available(iOS 13.0, *) {
             vc = storyBoard.instantiateViewController(identifier: Identifier.rawValue)
        } else {
            vc = storyBoard.instantiateViewController(withIdentifier: Identifier.rawValue)
        }

    let sheetController = SheetViewController(controller: vc, sizes: [.percent(0.5), .marginFromTop(21)], options: options)
        sheetController.allowGestureThroughOverlay = true
        sheetController.cornerRadius = 0
        sheetController.animateIn(to: view, in: controller)
    
       
    }
//}
