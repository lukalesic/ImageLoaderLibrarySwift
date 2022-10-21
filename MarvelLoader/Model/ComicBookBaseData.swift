//
//  Comic.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..

import UIKit
import Foundation

struct ComicBookBaseData: Codable {
    let code: Int?
    let data: ComicBookData?
    
    enum CodingKeys: String, CodingKey{
        case code = "code"
        case data = "data"
    }
}


