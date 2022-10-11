//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit

class HomeTableViewController: UIViewController {
    
    static let loader = Loader()
    var tableView = UITableView()
    var comicBook: ComicBook?
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Marvel Loader"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        Task{
            do {
                try await self.loadData()
                tableView.reloadData()
            }
            catch{ print("error") }
        }
        configureTableView()
        tableView.reloadData()
    }

    func loadData() async  {
        let request = URL(string: generatedURL)!
        
        do{
            self.comicBook = try await HomeTableViewController.loader.loadImage(url: request) as? ComicBook
        }
        catch{
            print("error")
        }
        tableView.reloadData()
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(ComicCell.self, forCellReuseIdentifier: Cells.comicCell)
    }

    func setTableViewDelegates(){
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
        return comicBook?.data?.comicbooks?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.comicCell) as! ComicCell
        let cbm = comicBook?.data?.comicbooks?[indexPath.row]
        cell.setData(comicBookModel: cbm)
     
        
        return cell
    }
}


