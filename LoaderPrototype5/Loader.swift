//
//  Loader.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import Foundation
import SwiftUI


private enum ImageStatus {
    case inProgress(Task<UIImage, Error>)
    case fetched(UIImage)
    case failure(Error)
}

enum InternetError: Error {
    case noInternet
    case invalidServerResponse
    
    var alert: Alert {
        switch self {
        case .noInternet:
            return Alert(title: Text("title"), message: Text("Message"))
            // return NSLocalizedString("No Internet connection available.", comment: "")
        case .invalidServerResponse:
            return Alert(title: Text("title"), message: Text("Message"))
            // return NSLocalizedString("Invalid server response.", comment: "")
        }
    }
}

actor Loader{
    // @Binding var showingAlert: Bool
    @Published var errors: Error?
    
    private var images: [URLRequest: ImageStatus] = [:]
    let queue = DispatchQueue.global(qos: .background)
    let semaphore = DispatchSemaphore(value: 3)
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
                //self.showingAlert = true
                // print(self.showingAlert)
                print("error caught")
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
