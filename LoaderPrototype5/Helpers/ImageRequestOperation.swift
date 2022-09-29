//
//  ImageRequestOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation
import UIKit


class ImageRequestOperation: DataRequestOperation {
    
    static let customImageCache = CustomCacheManager.shared
    
    init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        super.init(session: session, request: request, cache: ImageRequestOperation.customImageCache) { result in
            
            switch result {
            case .failure(let error):
                let image = UIImage(systemName: "wifi.exclamationmark")!
                DispatchQueue.main.async { completionHandler(.failure(error))
            }
                
            case .success(let data):
                let req = "\(request)"
                if let image = ImageRequestOperation.customImageCache.getImageWithKey(req) {
                    DispatchQueue.main.async { completionHandler(.success(image)) }
                    return
                }
                else {
                    let dataTask = URLSession.shared.dataTask(with: request) {data, response, _ in
                        if let data = data {
                            let image = UIImage(data: data)
                            print("Adding image to cache")
                            ImageRequestOperation.customImageCache.saveImageToCache(image!, key: req)
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
