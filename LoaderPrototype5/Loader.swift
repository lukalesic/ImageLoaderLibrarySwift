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

            images[urlRequest] = .inProgress(task)

            let image = try await task.value

            images[urlRequest] = .fetched(image)

            return image
    }
    
    
}
