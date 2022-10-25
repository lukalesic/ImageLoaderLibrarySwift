//
//  IssueNumberCellViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 21.10.2022..
//

import Foundation
import UIKit

struct IssueNumberCellViewModel {
    
    var issueNumber: String?

    init(comic: Comic){
        if comic.issueNumber == 0 {issueNumber = "No issue number available"}
        else {  issueNumber = "Issue number: \(comic.issueNumber!)"
        }
    }
}
