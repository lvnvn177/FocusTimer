//
//  AppDelegate.swift
//  FocusTimer
//
//  Created by 이영호 on 10/22/24.
//

import UIKit
import GoogleMobileAds


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
