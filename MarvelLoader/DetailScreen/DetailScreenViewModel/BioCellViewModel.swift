//
//  BioCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

struct BioCellViewModel {
    
    var comicDescription: String?

    init(comic: Comic){
        if comic.description == "" {comicDescription = "No description available for this particular comic."}
        else {comicDescription = comic.description}
    }
    

}
