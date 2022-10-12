//
//  MoreInfoTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {
    
    var desc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder more info text"
        
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

}
