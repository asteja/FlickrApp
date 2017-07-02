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
    var viewController:UIViewController?
    var client:APIWebService?
    
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.client = APIWebService()
        self.client?.downloadImages()
        
        return true
    }
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.viewController = UIViewController()
        self.viewController?.view.backgroundColor = UIColor.blue
        self.presentTableView()
                
        return true
    }

}

extension AppDelegate {
   
    func presentTableView() {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.viewController
        self.window?.makeKeyAndVisible()
        
    }
    
}





