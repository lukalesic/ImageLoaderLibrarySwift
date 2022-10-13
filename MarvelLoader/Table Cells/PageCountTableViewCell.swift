//
//  PageCountTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 13.10.2022..
//

import UIKit

class PageCountTableViewCell: UITableViewCell {
    
    var desc: UILabel = {
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
        contentView.addSubview(desc)
        desc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        desc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        desc.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: desc.bottomAnchor, constant: 7).isActive = true
        
    }

    func setComicDetails(comic: Comic){
        if comic.pageCount == 0 {desc.text = "No page count information available"}
        else{ desc.text = "\(comic.pageCount!) pages"}
    }
}