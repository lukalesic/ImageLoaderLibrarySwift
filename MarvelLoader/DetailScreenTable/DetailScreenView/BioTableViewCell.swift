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

    var comicDescription = UILabel()
    
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
        comicDescription = BioViewModel.setupComicDescription(comicDescription)
        BioViewModel.setDescriptionConstraints(comicDescription)
    }
    
    
    func setComicData(comic: Comic){
        if comic.description == "" {comicDescription.text = "No description available for this particular comic."}
        else {comicDescription.text = comic.description}
    }
    
  
}
