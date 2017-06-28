//
//  AppDelegate.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/24/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController:UINavigationController?
    var photosViewController:PhotosViewController?
    var viewController:UIViewController?
    var client:APIWebService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.viewController = UIViewController()
        self.viewController?.view.backgroundColor = UIColor.blue
        
        self.client = APIWebService()
        self.client?.downloadImages()
        
        self.presentTableView()
                
        return true
        
    }

}

extension AppDelegate {
   
    func presentTableView() {
        
        print("presenting table view")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navController = UINavigationController()
        self.navController?.pushViewController(self.viewController!, animated: true)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
    }
    
}





