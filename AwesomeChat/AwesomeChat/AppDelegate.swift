//
//  AppDelegate.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupView()
        return true
    }
    
    // Setup View
    private func setupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabbarViewController()
        window?.makeKeyAndVisible()
    }
}
