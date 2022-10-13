//
//  BioTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class BioTableViewCell: UITableViewCell {

    var bio: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder bio text"
        
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
    
    private func displayLayout(){
        contentView.addSubview(bio)
        bio.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        bio.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        bio.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: bio.bottomAnchor, constant: 7).isActive = true
        
    }
    
    func setComicData(comic: Comic){
        if comic.description == "" {bio.text = "No description available for this particular comic."}
        else {bio.text = comic.description}
    }
    
  
}
