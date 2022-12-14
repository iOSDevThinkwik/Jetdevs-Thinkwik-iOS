//
//  UITextField+Extensions.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation
import UIKit



extension UITextField {
    
    var placeholderColors: UIColor? {
        get {
            return self.placeholderColors
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
   
    func borderWidth(size:CGFloat){
        self.layer.borderWidth = size
    }
    
    func setCornerRadius(size:CGFloat){
        self.layer.cornerRadius = size
    }
   
    //set begginning space - left space
    func setLeftPadding(paddingValue:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingValue, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = paddingView
    }
    
    //set end of space
    func setRightPadding(paddingValue:CGFloat){
        let paddingView = UIView(frame: CGRect(x: (self.frame.size.width - paddingValue), y: 0, width: paddingValue, height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = paddingView
    }
    
    
    
    
   
}
