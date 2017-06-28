//
//  APIWebService.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/25/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

let URL = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=b5a0ccbed304ecb5057e8345d3baff55&date=&format=json&nojsoncallback=1&api_sig=efb1014da450419b65a0aff913b564d9"

class APIWebService: NSObject {
    
    var downloadPhotos = [Photo]()
    
    func downloadImages() {
        
        print("downloading the images....")
        
        let request = URLRequest(url: NSURL(string: URL)! as URL)
        let session = URLSession.shared
        
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject] {
                    
                    print(json)
                    
                    for case let result in json["photos"]!["photo"] as! [Any] {
                        print(result)
                        self.downloadPhotos.append(Photo(dictionary: result as! [String: Any]))
                    }
                    
                    print("downloading the images End....")
                    
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.navController?.pushViewController(PhotosViewController(), animated: true)
                    
                    
                }
        }
        task.resume()

    }
    
    func downloadImage(url:URL, completion: @escaping (UIImage)->Void) {
        
        print("downloading the image with url")
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let image = UIImage(data: data!) {
                completion(image)
            }
        }
        task.resume()
        
    }

    
}
