//
//  PageCountTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 13.10.2022..
//

import UIKit

class PageCountTableViewCell: UITableViewCell {
    
    var pageCount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder page count text"
        
        return label
    }()
    
    
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

        pageCount.configureForAutoLayout()
        pageCount.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 8, left: 10, bottom: 8, right: 10))

    }

    func setComicDetails(comic: Comic){
        if comic.pageCount == 0 {pageCount.text = "No page count information available"}
        else{ pageCount.text = "\(comic.pageCount!) pages"}
    }
}
