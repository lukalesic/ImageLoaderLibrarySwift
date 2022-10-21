//
//  ComicBookData.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation

struct ComicBookData: Codable {
    let comicbooks: [Comic]?
    
    enum CodingKeys: String, CodingKey{
        case comicbooks = "results"
    }
}
