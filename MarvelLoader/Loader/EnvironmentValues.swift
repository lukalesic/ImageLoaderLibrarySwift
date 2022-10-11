//
//  EnvironmentValues.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import Foundation
import SwiftUI
import CryptoKit

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = Loader()
}

extension EnvironmentValues {
    var imageLoader: Loader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self ] = newValue}
    }
}

extension String {
var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

struct Cells {
    static let comicCell = "ComicCell"
}



extension UIImage {
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
}



