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
    let client = APIWebService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navController = UINavigationController()
      
        self.client.downloadImages {
            self.photosViewController = PhotosViewController()
            self.navController!.pushViewController(self.photosViewController!, animated: true)
        }
     
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}





