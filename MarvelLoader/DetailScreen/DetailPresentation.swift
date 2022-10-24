//
//  DetailPresentation.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class DetailPresentation: NSObject{
    
    weak var controller: DetailViewController?
    var dataSource = DetailDataSource()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        return table
    }()
    
    func displayLayout(){
        guard let controller = controller else {return}
        
        controller.view.addSubview(tableView)
        
        tableView.configureForAutoLayout()
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(BioTableViewCell.self, forCellReuseIdentifier: "BioCell")
        tableView.register(IssueNumberTableViewCell.self, forCellReuseIdentifier: "MoreInfoCell")
        tableView.register(PageCountTableViewCell.self, forCellReuseIdentifier: "PageCountCell")

        tableView.dataSource = dataSource
        dataSource.comicDetail = controller.comicDetail
        tableView.delegate = self
    }
   
 
    
    private func setupHeader(title: String, tableView: UITableView) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = .clear
        
        let infoImage = UIImage(systemName: "info.circle")!.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        
        let infoImageView = UIImageView(image: infoImage)
        infoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerTitle = UILabel()
        headerTitle.text = title
        headerTitle.font = UIFont.boldSystemFont(ofSize: 20)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerTitle)
        headerView.addSubview(infoImageView)
    
        infoImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        infoImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        infoImageView.autoSetDimension(.width, toSize: 20)
        
        headerTitle.autoPinEdge(.left, to: .right, of: infoImageView, withOffset: 8)
        headerTitle.autoPinEdge(toSuperviewEdge: .right)
        headerTitle.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)

        return headerView
    }
    
    
}


extension DetailPresentation: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return setupHeader(title: "Description", tableView: tableView)
        }else if section == 2 {
            return setupHeader(title: "Issue", tableView: tableView)
        }  else if section == 3 {
            return setupHeader(title: "Page Count", tableView: tableView)
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 || section == 3 {return 20}
        return 0
        
    }
}
