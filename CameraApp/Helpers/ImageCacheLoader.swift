//
//  ImageCacheLoader.swift
//  CameraApp
//
//  Created by Tanya Berezovsky on 19/10/2021.
//

import UIKit

public class ImageCacheLoader {
    
    private var cache: NSCache<NSString, UIImage>
    private var imagePath: String
    
    public init(imagePath: String, cache: NSCache<NSString, UIImage>) {
        self.cache = cache
        self.imagePath = imagePath
    }
    
    public func obtainImageWithPath(imagePath: String, completionHandler: @escaping ((UIImage) -> ())) {
        
        if let image = getImageCache(imagePath: imagePath) {
            return completionHandler(image)
        }

        let queue = DispatchQueue.global(qos: .default)
        
        queue.async { [weak self] in
            
            guard let strongSelf = self else {
                return
            }
            
            let image = UIImage(contentsOfFile: strongSelf.imagePath) ?? UIImage()
            self?.cache.setObject(image, forKey: imagePath as NSString)
            
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
    }
    
    private func getImageCache(imagePath: String) -> UIImage? {
        guard let image = self.cache.object(forKey: imagePath as NSString) else {
              return nil
        }
        return image
    }

}

