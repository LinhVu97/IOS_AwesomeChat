//
//  ExtensionsView.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 23/07/2021.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.ok, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
