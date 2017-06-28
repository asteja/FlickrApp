//
//  PhotosViewController.swift
//  FlickrApp
//
//  Created by Saiteja Alle on 6/24/17.
//  Copyright © 2017 Saiteja Alle. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {
    
    var operationQ:OperationQueue?
    var client:APIWebService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.client = appDelegate?.client
        
        print("------------------", appDelegate?.client.downloadPhotos)
        
        self.operationQ = OperationQueue()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.client?.downloadPhotos!.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        
        
        if self.client?.downloadPhotos != nil {
            self.operationQ?.addOperation {
                self.downloadImage(url: (self.client?.downloadPhotos?[indexPath.row].getURL())!, completion: { (image) in
                    OperationQueue.main.addOperation {
                        imageView.image = image
                    }
                })
            }
        }
        
        cell.addSubview(imageView)
        
        cell.textLabel?.text = "Table View Cell"
        return cell
    }
    
    
    func downloadImage(url:URL, completion: @escaping (UIImage)->Void) {
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            completion(image!)
        }
        task.resume()
        
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
