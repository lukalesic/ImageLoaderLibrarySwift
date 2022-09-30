//
//  ImageRequestOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation
import UIKit
import SwiftUI

class ImageRequestOperation: DataRequestOperation {
    static let customImageCache = CustomCacheManager.shared
    
      private static func key(from request: URLRequest) -> String {
        let key = "file\(fileCounter)"
        fileCounter += 1
        print(key)
        return key
    }
    
    /* private static func key(for key: String) -> String {
        var myURL = URL(string: key)!
        return myURL.deletingPathExtension().lastPathComponent
    }*/
    
    init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        super.init(session: session, request: request, cache: ImageRequestOperation.customImageCache) { result in
            
            switch result {
            case .failure(let error):
                let image = UIImage(systemName: "wifi.exclamationmark")!
                DispatchQueue.main.async { completionHandler(.failure(error))
            }
                
            case .success(let data):
                let fileKey = ImageRequestOperation.key(from: request)
             //  let req = "\(request)"
            //  let fileKey = ImageRequestOperation.key(for: req)
              
                if let image = ImageRequestOperation.customImageCache.getImageWithKey(fileKey) {
                    print("Displaying image from cache")
                    DispatchQueue.main.async { completionHandler(.success(image)) }
                    return
                }
                else {
                    let dataTask = URLSession.shared.dataTask(with: request) {data, response, _ in
                        if let data = data {
                            let image = UIImage(data: data)
                            print("Adding image to cache")
                            ImageRequestOperation.customImageCache.saveImageToCache(image!, key: fileKey)
                            DispatchQueue.main.async { completionHandler(.success(image!)) }
                        }
                    }
                    dataTask.resume()
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async { completionHandler(.failure(URLError(.badServerResponse))) }
                    return
                }
            }
        }
    }
}
