//
//  AppDelegate.swift
//  MobilliumQRCodeReader
//
//  Created by mrtcelebi on 03/30/2022.
//  Copyright (c) 2022 mrtcelebi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        window?.rootViewController = HomeViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
