//
//  Loader.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import Foundation
import SwiftUI
import Dispatch


private enum ImageStatus {
    case inProgress(Task<UIImage, Error>)
    case failure(Error)
}

enum InternetError: Error {
    case noInternet
    case invalidServerResponse
    
    var description: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("No Internet connection available.", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Invalid server response.", comment: "")
        }
    }
}

actor Loader{
    
    private var images: [URLRequest: ImageStatus] = [:]
    let session: URLSession = .shared
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        return queue
    }()
    
    public func loadImage(url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await loadImage(request)
    }
    
    public func loadImage(_ request: URLRequest) async throws -> UIImage {
        
        switch images[request] {
        case .inProgress(let task):
            return try await task.value
            
        case .failure(let error):
            throw error
            
        case nil:
            //ovaj lazy var ne treba deklarirati unutar funkcije. izvaditi van kao instance varijablu.
            let allowedDiskSize = 100 * 1024 * 1024
            lazy var URLImageCache: URLCache = {
                return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize, diskPath: "imageCache")
            }()
            
            let task: Task<UIImage, Error> = Task {
                
                try await withCheckedThrowingContinuation { continuation in
                    let operation = ImageRequestOperation(session: session, request: request, cache: CustomCacheManager.shared) { [weak self] result in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                continuation.resume(throwing: error)
                                
                            case .success(let image):
                                continuation.resume(returning: image)
                            }
                        }
                    }
                    
                    queue.addOperation(operation)
                }
            }
            
            images[request] = .inProgress(task)
            
            return try await task.value
        }
    }
  
    
    class ImageRequestOperation: DataRequestOperation {
        
        static let customImageCache = CustomCacheManager.shared
        
        init(session: URLSession, request: URLRequest, cache: CustomCacheManager, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
            
            super.init(session: session, request: request, cache: Loader.ImageRequestOperation.customImageCache) { result in
                
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async { completionHandler(.failure(error))
                        let image = UIImage(systemName: "wifi.exclamationmark")!
                    }
                    
                case .success(let data):
                    let req = "\(request)"
                    if let image = Loader.ImageRequestOperation.customImageCache.getImageWithKey(req) {
                        DispatchQueue.main.async { completionHandler(.success(image)) }
                        return
                    }
                    else {
                        //ovdje ide kod za dodavanje u cache
                        let dataTask = URLSession.shared.dataTask(with: request) {data, response, _ in
                            if let data = data {
                                let cachedData = CachedURLResponse(response: response!, data: data)
                                let image = UIImage(data: data)
                                Loader.ImageRequestOperation.customImageCache.saveImageToCache(image!, key: req)
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
}



@propertyWrapper
struct Atomic<T> {
    var _wrappedValue: T
    let lock = NSLock()
    
    var wrappedValue: T {
        get { synchronized { _wrappedValue } }
        set { synchronized { _wrappedValue = newValue } }
    }
    
    init(wrappedValue: T) {
        _wrappedValue = wrappedValue
    }
    
    func synchronized<T>(block: () throws -> T) rethrows -> T {
        lock.lock()
        defer { lock.unlock() }
        return try block()
    }
}



