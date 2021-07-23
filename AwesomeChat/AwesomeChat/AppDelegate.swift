//
//  AppDelegate.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.1) // Delay Thread
        FirebaseApp.configure() // Connect to Firebase
        setupView()
        return true
    }
    
    // Setup View
    private func setupView() {
        let naviTabbar = UINavigationController(rootViewController: TabbarViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = naviTabbar
        window?.makeKeyAndVisible()
    }
}
