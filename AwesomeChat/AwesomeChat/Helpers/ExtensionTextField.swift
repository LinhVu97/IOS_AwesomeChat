//
//  ExtensionTextField.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.height - 1,
                                  width: self.frame.width + 20,
                                  height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
