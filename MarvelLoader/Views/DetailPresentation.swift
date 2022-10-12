//
//  DetailPresentation.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 12.10.2022..
//

import UIKit

class DetailPresentation: NSObject, UITableViewDelegate{
    
    weak var controller: DetailViewController?
    var dataSource = DetailDataSource()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        return table
    }()
    
    func displayLayout(){
        guard let controller = controller else {return}
        
        controller.view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true

        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(BioTableViewCell.self, forCellReuseIdentifier: "BioCell")
        tableView.register(MoreInfoTableViewCell.self, forCellReuseIdentifier: "MoreInfoCell")

        tableView.dataSource = dataSource
        tableView.delegate = self
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return setupHeader(title: "Bio", tableView: tableView)
        }else if section == 2 {
            return setupHeader(title: "More Info", tableView: tableView)
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2 {return 20}
        return 0
    }
    
    private func setupHeader(title: String, tableView: UITableView) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = .clear
        
        let headerTitle = UILabel()
        headerTitle.text = title
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerTitle)
        
        headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
      //  headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        
        return headerView
    }
    
    
}
