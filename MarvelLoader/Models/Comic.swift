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

struct ComicBookData: Codable {
    let comicbooks: [Comic]?
    
    enum CodingKeys: String, CodingKey{
        case comicbooks = "results"
    }
}

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let issueNumber:  Int?
    let pageCount: Int?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey{
        case path
        case ext = "extension"
    }
    
}


