//
//  OTPTextField.swift
//  LifeArt
//
//  Created by Muhammad Imran on 06/04/2021.
//
import Foundation
import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
        previousTextField?.layer.borderColor = UIColor(ciColor: .gray).cgColor
        previousTextField?.layer.borderWidth = 1.0
        nextTextField?.layer.borderColor = UIColor(ciColor: .gray).cgColor
        nextTextField?.layer.borderWidth = 1.0
    }
    
}
