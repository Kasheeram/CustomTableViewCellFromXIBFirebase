//
//  Extensions.swift
//  CustomTableViewCellFromXIB
//
//  Created by Apogee on 9/29/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String){
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject){
            self.image = cachedImage as! UIImage
            return
        }
        
        // otherwise fire off a new download
        URLSession.shared.dataTask(with: NSURL(string: (urlString as! String))! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("error123=\(error)")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let downloadedImage = UIImage(data: data!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}
