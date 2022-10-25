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
        
        //pure layout ovdje definiraj
        setTableViewDelegates()
        tableView.rowHeight = 100  //automatic dimensions..UItableview.cellautomaticdimensions.  comicCell onda mora imati postavlejne constraintove da tableView izracuna njegov height samostalno. 
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
        //ovo s frame izmjeniti u pure tj ukloniti idealno
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
        let comic = comicsViewModel.comics?.data?.comicbooks?[indexPath.row]
        let detailView = DetailViewController(comic: comic)
      
        navigationController?.pushViewController(detailView, animated: true)
    }
}
