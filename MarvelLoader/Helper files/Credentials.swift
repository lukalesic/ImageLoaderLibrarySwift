//
//  Credentials.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 06.10.2022..
//

import Foundation

let privateKey = "66f07b1f3dbf088a19ac6be96bb37c98f5a152d9"
let publicKey = "6baec989cdf6b0b0597e1c7a274f62de"
let timeStamp = "1"

var generatedURL: String {
    let generatedHash = "\(timeStamp)\(privateKey)\(publicKey)".MD5
    return "https://gateway.marvel.com/v1/public/comics?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(generatedHash)"
}

enum Section: Hashable {
  case main
}

