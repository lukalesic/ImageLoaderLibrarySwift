//
//  BioTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit
import PureLayout

class BioTableViewCell: UITableViewCell {
    
    var BioViewModel = BioCellViewModel()

    var comicDescription: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.font = label.font.withSize(15)
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
        contentView.addSubview(comicDescription)
        setDescriptionConstraints()
    }
    
    func setDescriptionConstraints(){
        comicDescription.configureForAutoLayout()
        comicDescription.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 8, left: 10, bottom: 8, right: 10))
    }
    
    func setComicData(comic: Comic){
        if comic.description == "" {comicDescription.text = "No description available for this particular comic."}
        else {comicDescription.text = comic.description}
    }
    
  
}
