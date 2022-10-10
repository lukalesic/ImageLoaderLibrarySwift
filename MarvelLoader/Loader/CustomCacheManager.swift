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
    
    private func path(for key: String) -> URL {
        let filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return filePath.appendingPathComponent(key)
    }
    
    private func saveImageToCacheDirectory(_ image: UIImage, key: String) {
        let fileURL = path(for: key)
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
            return imageFromCache
        }
        else {
            let imageURL = path(for: key)
            if let image = UIImage(contentsOfFile: imageURL.path) {
                return image
            }
            else {
                return nil
            }
        }
    }
}
