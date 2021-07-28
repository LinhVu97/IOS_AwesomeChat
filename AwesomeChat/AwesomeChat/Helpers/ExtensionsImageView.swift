//
//  ExtensionsImageView.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 25/07/2021.
//

import UIKit

enum AssetIdentifier: String {
    case email = "email"
    case key = "key"
    case user = "user"
    case buttonBgActive = "ButtonBgActive"
    case buttonBgDisable = "ButtonBgDisable"
}

extension UIImage {
    convenience init?(asset: AssetIdentifier) {
        self.init(named: asset.rawValue)
    }
}
