//
//  IssueNumberCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

class IssueNumberCellViewModel {
    
    func setupIssueNumber(_ label: UILabel) -> UILabel {
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        label.text = "Placeholder more info text"
        
        return label
    }
    
     func setIssueNumberConstraints(issueNumber: UILabel){
        issueNumber.configureForAutoLayout()
        issueNumber.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 8, left: 10, bottom: 8, right: 10))
    }
    
    
}
