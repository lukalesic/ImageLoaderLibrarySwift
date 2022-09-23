//
//  Loader.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import Foundation
import SwiftUI
import Dispatch
import DispatchIntrospection



private enum ImageStatus {
    case inProgress(Task<UIImage, Error>)
    case fetched(UIImage)
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
    let queue = DispatchQueue.global(qos: .background)
    let imageCache = NSCache<AnyObject, AnyObject>()

    @Published private(set) var error: InternetError?
    @Published var hasError = false
    @Published var networkAlertShown = false
    
    public func loadImage(url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await loadImage(request)
    }
    
    public func loadImage(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest]{
            switch status{
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            case .failure(let error):
                self.hasError = true
                self.error = error as? InternetError
            }
        }
        
        
        let task: Task<UIImage, Error> = Task {
            do {
                let imageQueue = OperationQueue()
                imageQueue.maxConcurrentOperationCount = 1
                
                            
                let (imageData, response) = try await URLSession.shared.data(for: urlRequest)
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw InternetError.invalidServerResponse
                }
                
                guard let image = UIImage(data: imageData) else {
                    throw InternetError.noInternet
                }
                
                return image
            }
            catch {
                self.hasError = true
                images[urlRequest] = .failure(error)
                print("error caught in Loader")
                let image = UIImage(systemName: "wifi.exclamationmark")!
                return image
            }
        }
        
        do{
            images[urlRequest] = .inProgress(task)
            var image = try await task.value
            if let imageFromCache = imageCache.object(forKey: urlRequest as AnyObject) as? UIImage {
                image = imageFromCache
                return image
            }
            images[urlRequest] = .fetched(image)
            //storing image in cache
            imageCache.setObject(image, forKey: urlRequest as AnyObject)
            return image
        }
    }
}



class DownloadOperation : Operation {
    
    private var task : URLSessionDownloadTask!
    
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    
    // default state is ready (when the operation is created)
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
  
    init(session: URLSession, downloadTaskURL: URLRequest, completionHandler: ((URL?, URLResponse?, Error?) -> Void)?) {
        super.init()
        
        // use weak self to prevent retain cycle
        task = session.downloadTask(with: downloadTaskURL, completionHandler: { [weak self] (localURL, response, error) in
            
            /*
            if there is a custom completionHandler defined,
            pass the result gotten in downloadTask's completionHandler to the
            custom completionHandler
            */
            if let completionHandler = completionHandler {
                // localURL is the temporary URL the downloaded file is located
                completionHandler(localURL, response, error)
            }
            
           /*
             set the operation state to finished once
             the download task is completed or have error
           */
            self?.state = .finished
        })
    }

    override func start() {
      /*
      if the operation or queue got cancelled even
      before the operation has started, set the
      operation state to finished and return
      */
      if(self.isCancelled) {
          state = .finished
          return
      }
      
      // set the state to executing
      state = .executing
      
      print("downloading \(self.task.originalRequest?.url?.absoluteString ?? "")")
            
      // start the downloading
      self.task.resume()
  }

  override func cancel() {
      super.cancel()
    
      // cancel the downloading
      self.task.cancel()
  }
}
