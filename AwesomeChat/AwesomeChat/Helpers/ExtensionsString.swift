//
//  ExtensionsString.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 23/07/2021.
//

import UIKit

enum ValidateType {
    case email
    case password
}

enum Regex: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // . is special character so need \\ before .
    case password = ".{8,}" // (?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,} -> Option 2
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isValid(_ validateType: ValidateType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        
        switch validateType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: trimmedString)
    }
}
