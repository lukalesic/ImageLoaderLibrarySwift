//
//  DetailDataSource.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class DetailDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: DetailViewModel?
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameTableViewCell
            let nameCellViewModel = viewModel!.nameTableCellViewModel()
            cell.updateWith(viewModel: nameCellViewModel)

            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioCell", for: indexPath) as! BioTableViewCell
            let bioCellViewModel = viewModel!.bioCellViewModel()
            cell.updateWith(viewModel: bioCellViewModel)
            
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreInfoCell", for: indexPath) as! IssueNumberTableViewCell
            let issueNumberViewModel = viewModel!.issueNumberCellViewModel()
            cell.updateWith(viewModel: issueNumberViewModel)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PageCountCell", for: indexPath) as! PageCountTableViewCell
            let pageCountViewModel = viewModel!.pageCountViewModel()
            cell.updateWith(viewModel: pageCountViewModel)

            return cell
        }
    } 
}

