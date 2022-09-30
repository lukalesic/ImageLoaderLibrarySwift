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
        
        super.init { result in
            
            switch result {
                
            case .failure(let error):
                let image = UIImage(systemName: "wifi.exclamationmark")!
                DispatchQueue.main.async { completionHandler(.failure(error)) }
                
            case .success(let data):
                let fileKey = ImageRequestOperation.key(from: request)
                fileCounter += 1
                
                //  let req = "\(request)"
                //  let fileKey = ImageRequestOperation.key(for: req)
                
                if let image = cache.getImageWithKey(fileKey) {
                    print("Displaying image from cache")
                    DispatchQueue.main.async { completionHandler(.success(image)) }
                    self.finish()
                    return
                }
                else {
                    self.task = session.dataTask(with: request) {data, response, error in
                        
                        guard
                            let data = data,
                            let response = response as? HTTPURLResponse,
                            200 ..< 300 ~= response.statusCode
                        else {
                            completionHandler(.failure(error ?? URLError(.badServerResponse)))
                            return
                        }
                        
                        let image = UIImage(data: data)
                        print("Adding image to cache")
                        cache.saveImageToCache(image!, key: fileKey)
                        DispatchQueue.main.async { completionHandler(.success(image!)) }
                        self.finish()
                    }
                    self.task.resume()
                    return
                }
              
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async { completionHandler(.failure(URLError(.badServerResponse))) }
                    return
                }
            }
        }
    }
    
    override func main() {
       // task.resume()
    }
    
    override func cancel() {
        super.cancel()
        
       // task.cancel()
    }
}

