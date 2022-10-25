//
//  NameTableCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

class NameTableCellViewModel {
    
    @Published var photoURL: URL?
    @Published var comics: Comic?
    
    
    func generateURL(comic: Comic?) -> URL? {
       guard let path = comic?.thumbnail?.path, let ext = comic?.thumbnail?.ext else {return nil}
       let imagePath = path + "." + ext
       photoURL = URL(string: imagePath)!
       return photoURL
    }    
}
