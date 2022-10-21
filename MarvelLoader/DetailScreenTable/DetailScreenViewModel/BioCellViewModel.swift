//
//  BioCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

class BioCellViewModel {
    
    func setupComicDescription(_ comicDescription: UILabel) -> UILabel {
        comicDescription.numberOfLines = 0
        comicDescription.font = comicDescription.font.withSize(15)
        comicDescription.text = "Placeholder bio text"
        
        return comicDescription
    }
    
    func setDescriptionConstraints(_ comicDescription: UILabel){
        comicDescription.configureForAutoLayout()
        comicDescription.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 8, left: 10, bottom: 8, right: 10))
    }
}
