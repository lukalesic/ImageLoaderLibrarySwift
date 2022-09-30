//
//  EnvironmentValues.swift
//  LoaderPrototype5
//
//  Created by Luka Lešić on 15.09.2022..
//

import Foundation
import SwiftUI

struct ImageLoaderKey: EnvironmentKey {
    static let defaultValue = Loader()
}

extension EnvironmentValues {
    var imageLoader: Loader {
        get { self[ImageLoaderKey.self] }
        set { self[ImageLoaderKey.self ] = newValue}
    }
}

var randomString: String {
   let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   return String((0..<7).map{ _ in letters.randomElement()! })
 }

var fileCounter = 0
