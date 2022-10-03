//
//  ImageRequestOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation
import UIKit
import SwiftUI

class ImageRequestOperation: AsynchronousOperation {
    
    private var task: URLSessionDataTask!
    var session: URLSession
    var request: URLRequest
    var cache: CustomCacheManager
    let completionHandler: (Result<UIImage, Error>) -> Void
    
    private static func key(from request: URLRequest) -> String {
        let key = request.url?.absoluteString
        return key!.MD5
    }
    
    init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        self.session = session
        self.request = request
        self.cache = cache
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        let fileKey = ImageRequestOperation.key(from: request)
        
        if let image = cache.getImageWithKey(fileKey) {
            DispatchQueue.main.async {
                print("Displaying image from cache")
                self.completionHandler(.success(image))
                self.finish()
            }
        }
        else {
            task = session.dataTask(with: request) {data, response, error in
                
                guard
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    200 ..< 300 ~= response.statusCode
                else {
                    self.completionHandler(.failure(error ?? URLError(.badServerResponse)))
                    self.finish()
                    return
                }
                
                let image = UIImage(data: data)
                print("Adding image to cache")
                self.cache.saveImageToCache(image!, key: fileKey)
                DispatchQueue.main.async { self.completionHandler(.success(image!)) }
                self.finish()
            }
            task.resume()
            return
        }
    }
    
    override func cancel() {
        task.cancel()
        super.cancel()
    }
}

