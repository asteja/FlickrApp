//
//  PhotosCollectionViewController.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/28/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"

class PhotosCollectionViewController: UICollectionViewController {
    
    
    
    var client:APIWebService?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.client = appDelegate.client

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("number of Sections")
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items in section")
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("cell for indexpath")
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 120, height: 120))
        
        imageView.image =  #imageLiteral(resourceName: "flickr")
        
        if self.client?.downloadPhotos != nil {
            
            DispatchQueue.global(qos: .background).async {
                self.client!.downloadImage(url: (self.client?.downloadPhotos[indexPath.row].getURL())!, completion: { (image) in
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                })
            }
            
        }
        
        cell.clipsToBounds = true
        cell.addSubview(imageView)
        return cell

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        print("sizeforItemAtIndexPath")
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        print("insetForSectionAtIndex")
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    
}
