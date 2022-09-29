//
//  DataRequestOperation.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 29.09.2022..
//

import Foundation


class DataRequestOperation: AsynchronousOperation {
    private var task: URLSessionDataTask!
    
    init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        super.init()
        
        task = session.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200 ..< 300 ~= response.statusCode
            else {
                completionHandler(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completionHandler(.success(data))
            
            self.finish()
        }
    }
    
    override func main() {
        
        task.resume()
    }
    
    override func cancel() {
        super.cancel()
        
        task.cancel()
    }
}
