//
//  Comic.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation

struct Comic: Codable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let issueNumber:  Int?
    let pageCount: Int?
    let thumbnail: Thumbnail?
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    static func == (lhs: Comic, rhs: Comic) -> Bool {
      lhs.id == rhs.id
    }
}
