//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit

class HomeTableViewController: UIViewController, JSONParsing {
    
    static let loader = Loader()
    var tableView = UITableView()
    var comicBook: ComicBookBaseData?
        
    private var homeTableViewModel: HomeTableViewModel!
    
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
             try await downloadObject(url: request, completionHandler: { result in
                 switch result {
                 case .success(let result):
                     self.comicBook =  result as ComicBookBaseData
                     self.tableView.reloadData()
                 case .failure(let error):
                     print(error)
                 }
            })
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
    
    func downloadObject(url: URL, completionHandler: @escaping (Result<ComicBookBaseData, Error>) -> Void) async throws {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decode = JSONDecoder()
            if let data = data {
                do{
                    let result = try decode.decode(ComicBookBaseData.self, from: data)
                    DispatchQueue.main.async {
                        print("data loaded!!")
                        completionHandler(.success(result))
                    }
                }
                catch{print("Error")
                    completionHandler(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}

extension HomeTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicBook?.data?.comicbooks?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.comicCell) as! ComicCell
        let comic = comicBook?.data?.comicbooks?[indexPath.row]
        cell.setData(comicBookModel: comic)
     
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = comicBook?.data?.comicbooks?[indexPath.row]
        let detailView = DetailViewController()
        detailView.comicDetail = comic
        navigationController?.pushViewController(detailView, animated: true)
        
    }
}
