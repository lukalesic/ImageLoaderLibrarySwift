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
  }


actor Loader{
    private var images: [URLRequest: ImageStatus] = [:]
    let queue = DispatchQueue.global(qos: .background)
    let semaphore = DispatchSemaphore(value: 3)
    
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
            }
        }
        
     
        let task: Task<UIImage, Error> = Task {
                let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
                let image = UIImage(data: imageData)!
                return image
            }
        
        //unit testovi za async await
        //ispisati api call couont za sve
        //ograniciti api calls at a time
        //note to self: staviti u dispatch queue i semafor ucitavanje slike, mozda u for each petlju pod homoeview
        
        do{
          
            images[urlRequest] = .inProgress(task)
            let image = try await task.value
            images[urlRequest] = .fetched(image)
            return image
        }
        catch {
            print("Error displaying images")
            let image = UIImage()
            return image
        }
         
    }
    
    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) throws {
        guard let url = fileName(for: urlRequest),
              let data = image.jpegData(compressionQuality: 0.8) else {
            assertionFailure("Unable to generate a local path")
            return
        }
        try data.write(to: url)
    }
    
    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let fileName = urlRequest.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
                  return nil
              }

        return applicationSupport.appendingPathComponent(fileName)
    }
}
