//
//  DetailDataSource.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class DetailDataSource: NSObject, UITableViewDataSource {
    
    var comic: Comic?
    var viewModel = DetailViewModel()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameTableViewCell
           
           let nameViewModel = NameTableCellViewModel(comic: comic)
           cell.updateWith(viewModel: nameViewModel)

            
         //  let cellViewModel = self.viewModel.nameTableCellViewModel(at: indexPath)
         //   cell.updateWith(viewModel: cellViewModel)

            //  cell.updateWith(viewModel: viewModel)

            
            
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BioCell", for: indexPath) as! BioTableViewCell
            cell.setComicData(comic: comic!)
            
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoreInfoCell", for: indexPath) as! IssueNumberTableViewCell
            cell.setComicDetails(comic: comic!)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PageCountCell", for: indexPath) as! PageCountTableViewCell
            cell.setComicDetails(comic: comic!)
            return cell
        }
    } 
}

