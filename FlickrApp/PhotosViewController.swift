//
//  PhotosViewController.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/24/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {
    
    var client:APIWebService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.client = appDelegate.client
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("number of sections")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows in Section")
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("height for row")
        return 100
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cell for row at indexPath")

        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 20, width: 60, height: 60))
        
        if self.client?.downloadPhotos != nil {

            DispatchQueue.global(qos: .background).async {
                self.client!.downloadImage(url: (self.client?.downloadPhotos[indexPath.row].getURL())!, completion: { (image) in
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                })
            }
            
        }
        
        cell.addSubview(imageView)
        return cell
    }
    
    
  
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
