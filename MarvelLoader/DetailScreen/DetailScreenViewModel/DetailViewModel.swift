//
//  DetailViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation


class DetailViewModel {
  
    var comic: Comic?
      
     func nameTableCellViewModel(at: IndexPath) -> NameTableCellViewModel {
        
       let comic = comic
       let viewModel = NameTableCellViewModel(comic: comic)
       return viewModel
     }
    
}

