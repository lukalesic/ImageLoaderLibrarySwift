//
//  DetailViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 11.10.2022..
//

import UIKit

class DetailViewController: UIViewController {
    
    var comic: Comic?
    let infoImage = UIImage(systemName: "info.circle")!.withTintColor(.systemPink, renderingMode: .alwaysOriginal)

    var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        return table
    }()
    
    var dataSource = DetailDataSource()

    var detailViewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        title = "Details"
        setup()
    }
    
    private func setup(){
        displayLayout()
    }
    
    func displayLayout(){
        view.addSubview(tableView)
        
        tableView.configureForAutoLayout()
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "NameCell")
        tableView.register(BioTableViewCell.self, forCellReuseIdentifier: "BioCell")
        tableView.register(IssueNumberTableViewCell.self, forCellReuseIdentifier: "MoreInfoCell")
        tableView.register(PageCountTableViewCell.self, forCellReuseIdentifier: "PageCountCell")

        tableView.dataSource = dataSource
        dataSource.comic = comic
        tableView.delegate = self
    }
    
    private func setupHeader(title: String, tableView: UITableView) -> UIView {
        let headerTitle = UILabel()
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        let infoImageView = UIImageView(image: infoImage)

        headerView.backgroundColor = .clear
        headerTitle.text = title
        headerTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        headerView.addSubview(headerTitle)
        headerView.addSubview(infoImageView)
        setupHeaderConstraints(headerTitle: headerTitle, infoImageView: infoImageView)
        return headerView
    }
    
    private func setupHeaderConstraints(headerTitle: UILabel, infoImageView: UIImageView) {
        infoImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        infoImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        infoImageView.autoSetDimension(.width, toSize: 20)
        
        headerTitle.autoPinEdge(.left, to: .right, of: infoImageView, withOffset: 8)
        headerTitle.autoPinEdge(toSuperviewEdge: .right)
        headerTitle.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
    }
    
}


extension DetailViewController: UITableViewDelegate {
    
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
