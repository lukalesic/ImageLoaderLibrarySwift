//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit

class ComicTableViewController: UIViewController, ViewModelDelegate {
    
    var tableView = UITableView()
    private var comicsViewModel = ComicsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Loader"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        Task{
            do {
                try await comicsViewModel.loadData()
                reloadTable()
            }
            catch{ print("error") }
        }
        configureTableView()
        reloadTable()
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.configureForAutoLayout()
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        setTableViewDelegates()
        tableView.register(ComicCell.self, forCellReuseIdentifier: Cells.comicCell)
    }
    
    func setTableViewDelegates(){
        comicsViewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}
 

extension ComicTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsViewModel.numberOfRows(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.comicCell) as! ComicCell
         
        let cellViewModel = self.comicsViewModel.comicCellViewModel(at: indexPath)
        cell.updateWith(viewModel: cellViewModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = comicsViewModel.comicbooks![indexPath.row]
        let detailVM = DetailViewModel(comic: comic)
        let detailView = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
