//
//  PageCountCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 23.10.2022..
//

import Foundation
import UIKit

struct PageCountViewModel {
    
    var pageCount: String?
    
    init(comic: Comic){
        if comic.pageCount == 0 {pageCount = "No page count information available"}
        else{ pageCount = "\(comic.pageCount!) pages"}
    }
    
}
