//
//  Protocols.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 14.10.2022..
//

import Foundation
import UIKit

protocol ImageDownloading {
    func loadImageFromServer(comic: Comic?, imageView: UIImageView)
}
