//
//  Photo.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/25/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

class Photo {

    private var farmID:Int
    private var id, serverID, secret:String
    
    init(dictionary: [String:Any]) {
        self.farmID = dictionary["farm"]! as! Int
        self.id = dictionary["id"]! as! String
        self.secret = dictionary["secret"]! as! String
        self.serverID = dictionary["server"]! as! String
        
    }
    
    func getURL()->NSURL {
        
        print("getting url for the image")
        var url:NSURL!
        if let URLCreated = NSURL(string: NSString(format: "https://farm%d.staticflickr.com/%@/%@_%@.jpg", self.farmID, self.serverID, self.id, self.secret) as String) {
            url = URLCreated
        }
        return url
    }

}
