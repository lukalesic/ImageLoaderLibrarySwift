//
//  PageCountTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 13.10.2022..
//

import UIKit

class PageCountTableViewCell: UITableViewCell {
    
    var pageCountViewModel = PageCountViewModel()
    var pageCount = UILabel()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        displayLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayLayout(){
        contentView.addSubview(pageCount)
        pageCount = pageCountViewModel.setupPageCount(pageCount)
        pageCountViewModel.setPageCountConstraints(pageCount)
    }


    func setComicDetails(comic: Comic){
        if comic.pageCount == 0 {pageCount.text = "No page count information available"}
        else{ pageCount.text = "\(comic.pageCount!) pages"}
    }
}
