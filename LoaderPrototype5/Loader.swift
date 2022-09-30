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
}




