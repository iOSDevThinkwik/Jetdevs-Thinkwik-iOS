//
//  String+Extension.swift
//  JetDevsHomeWork
//
//  Created by Hemang Solanki on 14/12/22.
//

import Foundation
import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func trim()->String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    
}

