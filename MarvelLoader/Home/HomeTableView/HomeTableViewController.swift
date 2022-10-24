//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit

class HomeTableViewController: UIViewController, ViewModelDelegate {
    
    var tableView = UITableView()
    private var homeTableViewModel = HomeTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Loader"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes

        Task{
            do {
                try await homeTableViewModel.loadData()
                reloadTable()
            }
            catch{ print("error") }
        }
        configureTableView()
        tableView.reloadData()
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
        homeTableViewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
 

extension HomeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeTableViewModel.comic?.data?.comicbooks?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = homeTableViewModel.comic?.data?.comicbooks?[indexPath.row]
        var comicCellVM = ComicCellViewModel()
        
        let url = comicCellVM.generateURL(comic: comic)!
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.comicCell) as! ComicCell

        cell.loadImageFromServer(url: url)
        comicCellVM.setTitle(comic: comic)
      
        
       // let title = comicCellVM.generateTitle(comic: comic)!
       // cell.setTitle(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = homeTableViewModel.comic?.data?.comicbooks?[indexPath.row]
        let detailView = DetailViewController()
        detailView.comicDetail = comic
        navigationController?.pushViewController(detailView, animated: true)
    }
}
