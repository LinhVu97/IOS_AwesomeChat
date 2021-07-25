//
//  ExtensionTextField.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 23/07/2021.
//

import UIKit

extension UITextField {
    func addBottomBorder() {
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 1
        self.borderStyle = .none
    }
}
