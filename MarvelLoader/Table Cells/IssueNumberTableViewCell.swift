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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Placeholder more info text"
        
        return label
    }()
    
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
        contentView.addSubview(issueNumber)
        issueNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        issueNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        issueNumber.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: issueNumber.bottomAnchor, constant: 7).isActive = true
        
    }
    
    func setComicDetails(comic: Comic){
        if comic.issueNumber == 0 {issueNumber.text = "No issue number available"}
        else {  issueNumber.text = "Issue number: \(comic.issueNumber!)"
        }
        
    }
}
