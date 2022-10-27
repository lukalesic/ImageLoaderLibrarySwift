//
//  DetailViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation

class DetailViewModel {

    let comic: Comic?
    
    init(comic: Comic?){
        self.comic = comic
    }
    
    func nameTableCellViewModel() -> NameTableCellViewModel {
        let viewModel = NameTableCellViewModel(comic: comic)
        return viewModel
    }
    
    func issueNumberCellViewModel() -> IssueNumberCellViewModel {
        let viewModel = IssueNumberCellViewModel(comic: comic!)
        return viewModel
    }
    
    func bioCellViewModel() -> BioCellViewModel {
        let viewModel = BioCellViewModel(comic: comic!)
        return viewModel
    }
    
    func pageCountViewModel() -> PageCountViewModel {
        let viewModel = PageCountViewModel(comic: comic!)
        return viewModel
    }
    
}

