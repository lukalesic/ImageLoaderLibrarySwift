//
//  DetailViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation


class DetailViewModel {
    
    var comic: Comic?
    
    
    func nameTableCellViewModel(comic: Comic?) -> NameTableCellViewModel {
        let viewModel = NameTableCellViewModel(comic: comic)
        return viewModel
    }
    
    func issueNumberCellViewModel(comic: Comic?) -> IssueNumberCellViewModel {
        let viewModel = IssueNumberCellViewModel(comic: comic!)
        return viewModel
    }
    
    func bioCellViewModel(comic: Comic?) -> BioCellViewModel {
        let viewModel = BioCellViewModel(comic: comic!)
        return viewModel
    }
    
    func pageCountViewModel(comic: Comic?) -> PageCountViewModel {
        let viewModel = PageCountViewModel(comic: comic!)
        return viewModel
    }
    
}

