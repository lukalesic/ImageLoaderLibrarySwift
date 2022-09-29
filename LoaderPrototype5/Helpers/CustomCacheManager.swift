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
    let cacheDirectory = FileManager.SearchPathDirectory.cachesDirectory
    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask

    private init(){}
    
   var imageCache: NSCache<AnyObject, AnyObject> {
        var imageCache = NSCache<AnyObject, AnyObject>()
        imageCache.countLimit = 200
        imageCache.totalCostLimit = 1024 * 1024 * 100
        return imageCache
    }
            
    func saveImageToCacheDirectory(_ image: UIImage, key: String) {
        let randomInt = Int.random(in: 1..<100)
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return }
        let fileName = "file" + String(randomInt)
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        print("saved to directory: \(fileURL)")
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        do {
               try data.write(to: fileURL)
           } catch let error {
               print("error saving file:", error)
           }
       }
    
    func saveImageToCache(_ image: UIImage, key: String) {
        saveImageToCacheDirectory(image, key: key)
        imageCache.setObject(image as UIImage, forKey: key as AnyObject)
        print("saved to cache")
    }
    
    func removeImageFromCache(key: String) {
        imageCache.removeObject(forKey: key as AnyObject)
    }

    func getImageWithKey(_ key: String) -> UIImage? {
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) as? UIImage {
            print("Displaying image from memory cache")
            return imageFromCache
        }
        else {
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
