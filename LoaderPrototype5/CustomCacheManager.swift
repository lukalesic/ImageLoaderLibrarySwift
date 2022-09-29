//
//  CustomCacheManager.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation
import SwiftUI

class CustomCacheManager {
    
    static let shared = CustomCacheManager()

    private init(){}
    
   var imageCache: NSCache<AnyObject, AnyObject> {
        var imageCache = NSCache<AnyObject, AnyObject>()
        imageCache.countLimit = 200
        imageCache.totalCostLimit = 1024 * 1024 * 100
        return imageCache
    }
            
    func saveImageToCacheDirectory(_ image: UIImage, key: String) {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let fileName = key
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        do {
               try data.write(to: fileURL)
           } catch let error {
               print("error saving file with error", error)
           }
       }
    
    func saveImageToCache(_ image: UIImage, key: String) {
        saveImageToCacheDirectory(image, key: key)
        imageCache.setObject(image as UIImage, forKey: key as AnyObject)
    }
    
    func removeImageFromCache(key: String) {
        imageCache.removeObject(forKey: key as AnyObject)
    }

    func getImageWithKey(_ key: String) -> UIImage? {
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
            return imageFromCache
        }
        else {
            //je li ovo trebaju biti instance variables?
            let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask

            let paths = NSSearchPathForDirectoriesInDomains(cacheDirectory, userDomainMask, true)

            if let dirPath = paths.first {
                   let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(key)
                   let image = UIImage(contentsOfFile: imageUrl.path)
                   return image
               }
        }
        return nil
    }
    
}
