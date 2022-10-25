//
//  HomeTableViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation
import UIKit

protocol ViewModelDelegate: AnyObject {
    func reloadTable()
}

class ComicsViewModel {
   
    var comics: ComicBookBaseData?
    weak var delegate: ViewModelDelegate?
    
    func comicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
      let comic = comics?.data?.comicbooks![indexPath.row]
      let viewModel = ComicCellViewModel(comic: comic)
      return viewModel
    }
    
    func numberOfRows(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics?.data?.comicbooks?.count ?? 10
        //pojednostavniti, probati napraviti da ima instanca bas comics
    }
    

    func loadData() async  {
        let request = URL(string: generatedURL)!
        
        do{
            try await downloadObject(url: request, completionHandler: { result in
                switch result {
                case .success(let result):
                    self.comics = result as ComicBookBaseData
                    self.delegate?.reloadTable()
                case .failure(let error):
                    print(error)
                }
            })
        }
        catch{
            print("error")
        }
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


