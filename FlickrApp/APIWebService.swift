//
//  APIWebService.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/25/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

let URL = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=daba1eef441785014e3a41e88ff1a62c&format=json&nojsoncallback=1&api_sig=1123f9023ec7cd80ca6f8958ae7f0d79"

class APIWebService: NSObject {
    
    var downloadPhotos = [Photo]()
    var navController:UINavigationController = UINavigationController()

    
    func downloadImages() {
        
        print("downloading the images....")
        
        let request = URLRequest(url: NSURL(string: URL)! as URL)
        let session = URLSession.shared
        
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject] {
                                        
                    for case let result in json["photos"]!["photo"] as! [Any] {
                        self.downloadPhotos.append(Photo(dictionary: result as! [String: Any]))
                    }
                    
                    print("downloading the images End....")
                    
                    OperationQueue.main.addOperation {
                         self.presentView()
                    }
      
                    
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

    func presentView() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
       
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 125, height: 125)
       
        let photoCollectionView = PhotosCollectionViewController(collectionViewLayout: layout)
        photoCollectionView.collectionView?.setCollectionViewLayout(layout, animated: true)
        
        navController.pushViewController(photoCollectionView, animated: true)
        navController.navigationBar.topItem?.title = "Photos Collection"
        
        delegate.window?.rootViewController = navController
        

        
    }
    
}
