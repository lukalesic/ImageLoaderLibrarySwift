//
//  MoreInfoTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class IssueNumberTableViewCell: UITableViewCell {
    
    var issueNumber: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
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
        contentView.addSubview(issueNumber)
        
        issueNumber.configureForAutoLayout()
        issueNumber.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        issueNumber.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        issueNumber.autoAlignAxis(toSuperviewAxis: .horizontal)
        issueNumber.autoPinEdge(toSuperviewEdge: .bottom, withInset: 7)
        
    }
    
    func setComicDetails(comic: Comic){
        if comic.issueNumber == 0 {issueNumber.text = "No issue number available"}
        else {  issueNumber.text = "Issue number: \(comic.issueNumber!)"
        }
        
    }
}
