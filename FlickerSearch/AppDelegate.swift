//
//  AppDelegate.swift
//  FlickerSearch
//
//  Created by Fabricio Rodriguez on 9/5/18.
//  Copyright © 2018 Fabricio Rodriguez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        startSearchViewController()
        return true
    }
    
    private func startSearchViewController() {
        let viewModel = SearchPhotosViewModel()
        let scanViewController = SearchPhotosViewController.instantiate(with: viewModel)
        let navigationController = UINavigationController.init(rootViewController: scanViewController)
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
