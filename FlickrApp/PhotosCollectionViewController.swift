//
//  PhotosCollectionViewController.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/28/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit
import GameplayKit


private let reuseIdentifier = "reuseIdentifier"

class PhotosCollectionViewController: UICollectionViewController {

    var client:APIWebService?
    var timer:Timer?
    var cache:NSCache<NSURL, UIImage>?
    var downloadedPhotos:[Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.client = appDelegate.client
        
        self.cache = NSCache()
        self.downloadedPhotos = self.client!.downloadPhotos

        self.timer = Timer(timeInterval: 10, target: self, selector: #selector(shufflePhotos), userInfo: nil, repeats: true)
        self.timer?.fire()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        RunLoop.main.add(self.timer!, forMode: .defaultRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        
        imageView.image =  #imageLiteral(resourceName: "flickr")
        
        if self.cache?.object(forKey: self.downloadedPhotos![indexPath.row].getURL()) != nil {
            imageView.image = self.cache?.object(forKey: self.downloadedPhotos![indexPath.row].getURL())
        }else {
        
            if self.downloadedPhotos != nil && self.cache != nil{
            
                DispatchQueue.global(qos: .background).async {
                    self.client!.downloadImage(url: self.downloadedPhotos![indexPath.row].getURL(), completion: { (image) in
                    
                        self.cache?.setObject(image, forKey: self.client!.downloadPhotos[indexPath.row].getURL())
                    
                    
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    })
                }
            
            }
        }
       
        
        cell.clipsToBounds = true
        cell.addSubview(imageView)
        return cell

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func shufflePhotos() {
        
        var i:Int = 1
        var elements = [Int]()
        var shuffledPhotos = [Photo]()
        
        while i != self.downloadedPhotos!.count {
            
            let num:Int = Int(arc4random_uniform(UInt32(self.downloadedPhotos!.count))) + 1
            
            if elements.count <= self.downloadedPhotos!.count && !elements.contains(num) {
         
                elements.append(num)
                shuffledPhotos.append(self.downloadedPhotos![num-1])

            }
            else {
                i = i-1
            }
            
            i=i+1
        }
        
        self.downloadedPhotos!.removeAll()
        self.downloadedPhotos! = shuffledPhotos
        self.collectionView?.reloadData()
        
    }

    
}
