//
//  String+Validity.swift
//  Leaf
//
//  Created by Mohamed Atallah on 04/09/2025.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9][A-Za-z0-9.-]*[A-Za-z0-9]\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
   
    func isValidPassword() -> Bool {
        self.count >= 8
    }
}
