//
//  BioTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit
import PureLayout

class BioTableViewCell: UITableViewCell {

    var bio: UILabel = {
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
        contentView.addSubview(bio)
        
        bio.configureForAutoLayout()    
        bio.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        bio.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        bio.autoAlignAxis(toSuperviewAxis: .horizontal)
        bio.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        
    }
    
    func setComicData(comic: Comic){
        if comic.description == "" {bio.text = "No description available for this particular comic."}
        else {bio.text = comic.description}
    }
    
  
}
