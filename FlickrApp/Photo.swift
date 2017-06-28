//
//  Photo.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/25/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

class Photo {
    private var farmID: Int
    private var id:String
    private var serverID, secret:String
    
    
    init(dictionary: [String:Any]) {
        self.farmID = dictionary["farm"]! as! Int
        self.id = dictionary["id"]! as! String
        self.secret = dictionary["secret"]! as! String
        self.serverID = dictionary["server"]! as! String
        
    }
    
    func getURL()->URL {
        var url:URL!
        if let URLCreated = NSURL(string: NSString(format: "https://farm%d.staticflickr.com/%d/%d_%@.jpg", self.farmID, self.id, self.secret, self.secret) as String) {
            url = URLCreated as URL
        }
        return url
    }

}
