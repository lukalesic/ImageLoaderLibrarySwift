//
//  NameTableCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

struct NameTableCellViewModel {
    
     var photoURL: URL?
     var title: String?
    
    init(comic: Comic?) {
        photoURL = URL(string: (comic?.thumbnail?.path ?? "") + "." + (comic?.thumbnail?.ext ?? ""))
        self.title = comic?.title
    }
}
