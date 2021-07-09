//
//  AppDelegate.swift
//  Book_Searcher
//
//  Created by Mac on 7/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let vc = SearchVC(nibName: "SearchVC", bundle: nil)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        return true
    }


}

