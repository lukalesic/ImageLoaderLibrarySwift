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
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(ComicCell.self, forCellReuseIdentifier: Cells.comicCell)
    }
    
    func setTableViewDelegates(){
        comicsViewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
 

extension ComicTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsViewModel.comics?.data?.comicbooks?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.comicCell) as! ComicCell
         
        let cellViewModel = self.comicsViewModel.cellViewModel(at: indexPath)
        cell.updateWith(viewModel: cellViewModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = comicsViewModel.comics?.data?.comicbooks?[indexPath.row]
        let detailView = DetailViewController()
        detailView.comicDetail = comic
        navigationController?.pushViewController(detailView, animated: true)
    }
}
