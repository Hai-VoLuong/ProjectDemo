//
//  ImageView+Extension.swift
//  projectDemo
//
//  Created by MAC on 1/10/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        // check cache for image first
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, err) in
            guard let this = self else { return }
            
            //download hit an error so lets return out
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!) {
                    // save into cache
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    this.image = downloadImage
                }
            }
        }.resume()
    }
}
