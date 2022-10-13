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

