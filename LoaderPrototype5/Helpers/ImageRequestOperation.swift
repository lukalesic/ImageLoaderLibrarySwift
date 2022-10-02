//
//  ImageRequestOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

//kuzis predajemo vec session.. na sessionu data task zovem i onda taj data spremim u cache i vratim pozivatelju kroz completion handler


import Foundation
import UIKit
import SwiftUI

class ImageRequestOperation: AsynchronousOperation {
    
    private var task: URLSessionDataTask!
    var session: URLSession
    var request: URLRequest
    var cache: CustomCacheManager
    let completionHandler: (Result<UIImage, Error>) -> Void
    
    //ukloniti file counter iz env values, ovu funkciju isto - url request najbolje pretvoriti u string, taj urlstring pretvoris u hash. md5 hash? 
    private static func key(from request: URLRequest) -> String {
        let key = "file\(fileCounter)"
        print(key)
        return key
    }
    
    /* private static func key(for key: String) -> String {
     var myURL = URL(string: key)!
     return myURL.deletingPathExtension().lastPathComponent
     }*/
    
    init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        self.session = session
        self.request = request
        self.cache = cache
        self.completionHandler = completionHandler
        super.init()
    }
    
    
    override func main() {
        let fileKey = ImageRequestOperation.key(from: request)
        fileCounter += 1
        
        //  let req = "\(request)"
        //  let fileKey = ImageRequestOperation.key(for: req)
        
        if let image = cache.getImageWithKey(fileKey) {
            DispatchQueue.main.async {
                print("Displaying image from cache")
                self.completionHandler(.success(image))
                self.finish()
                return
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

