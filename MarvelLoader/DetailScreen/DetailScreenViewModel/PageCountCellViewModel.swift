//
//  PageCountCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 23.10.2022..
//

import Foundation
import UIKit

class PageCountViewModel {
    
    func setupPageCount(_ pageCount: UILabel) -> UILabel {
        pageCount.numberOfLines = 0
        pageCount.font = pageCount.font.withSize(15)
        pageCount.translatesAutoresizingMaskIntoConstraints = false
        pageCount.text = "Placeholder page count text"
        return pageCount
    }
    
    func setPageCountConstraints(_ pageCount: UILabel){
        pageCount.configureForAutoLayout()
        pageCount.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 8, left: 10, bottom: 8, right: 10))
    }
    
}
