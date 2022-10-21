//
//  MoreInfoTableViewCell.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class IssueNumberTableViewCell: UITableViewCell {
    
    var IssueNumberViewModel = IssueNumberCellViewModel()
    
    var issueNumber = UILabel()
    
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
        issueNumber = IssueNumberViewModel.setupIssueNumber(issueNumber)
        IssueNumberViewModel.setIssueNumberConstraints(issueNumber: issueNumber)
    }
    

    func setComicDetails(comic: Comic){
        if comic.issueNumber == 0 {issueNumber.text = "No issue number available"}
        else {  issueNumber.text = "Issue number: \(comic.issueNumber!)"
        }
        
    }
}
