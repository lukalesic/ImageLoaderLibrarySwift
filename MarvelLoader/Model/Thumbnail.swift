//
//  Thumbnail.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation



struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey{
        case path
        case ext = "extension"
    }
    
}


