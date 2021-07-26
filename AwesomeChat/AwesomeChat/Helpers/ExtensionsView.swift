//
//  ExtensionsView.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 23/07/2021.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String, completionHandler: () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localized.ok, style: .default, handler: nil))
        completionHandler()
        present(alert, animated: true, completion: nil)
    }
    
    func alertHandle(title: String, message: String, titleAction: String, completionHandler: @escaping () -> Void) {
        let alertCreateAcc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertCreateAcc.addAction(UIAlertAction(title: titleAction, style: .default, handler: { [weak self] _ in
            completionHandler()
        }))
        alertCreateAcc.addAction(UIAlertAction(title: Localized.cancel, style: .cancel, handler: nil))
        present(alertCreateAcc, animated: true, completion: nil)
    }
}
