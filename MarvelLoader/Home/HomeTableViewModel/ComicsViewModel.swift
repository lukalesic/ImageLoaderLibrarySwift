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
   
    var comicbooks: [Comic]? = []
    weak var delegate: ViewModelDelegate?
    
    func comicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        let comic = comicbooks?[indexPath.row]
        let viewModel = ComicCellViewModel(comic: comic)
        return viewModel
    }
    
    func numberOfRows(numberOfRowsInSection section: Int) -> Int {
        return comicbooks?.count ?? 0
    }
    
    func loadData( completion: @escaping (_ success: Bool) -> Void)    {
        let request = URL(string: generatedURL)!
        Task{
            do{
                try await downloadObject(url: request, completionHandler: { result in
                    switch result {
                    case .success(let result):
                        self.comicbooks = result.data?.comicbooks
                        self.delegate?.reloadTable()
                        completion(true)
                    case .failure(let error):
                        print(error)
                        
                    }
                })
            }
            catch{
                print("error")
            }
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


