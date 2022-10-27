//
//  Comic.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation

//hashable
struct Comic: Codable {
    let id: Int
    let title: String
    let description: String?
    let issueNumber:  Int?
    let pageCount: Int?
    let thumbnail: Thumbnail?
}
