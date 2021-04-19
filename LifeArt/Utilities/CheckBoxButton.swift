//
//  CheckBoxButton.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {

    // Images
        let checkedImage = UIImage(named: "checkbox")! as UIImage
        let uncheckedImage = UIImage(named: "unchecked")! as UIImage

        // Bool property
        var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(uncheckedImage, for: .normal)
                } else {
                    self.setImage(checkedImage, for: .normal)
                }
            }
        }

        override func awakeFromNib() {
            self.isUserInteractionEnabled = false
            self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
            self.isChecked = false
        }

       @objc func buttonClicked(sender: UIButton) {
            if sender == self {
                if isChecked == true {
                    isChecked = false
                } else {
                    isChecked = true
                }
            }
        }

}
