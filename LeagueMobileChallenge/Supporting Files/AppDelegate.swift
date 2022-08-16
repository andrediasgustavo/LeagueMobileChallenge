//
//  AppDelegate.swift
//  LeagueMobileChallenge
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        self.window = UIWindow()
        let navigationController = UINavigationController()
        let apiService = APIController()
        let viewModel = HomeViewModel(apiService: apiService)
        let homeViewController = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([homeViewController], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

