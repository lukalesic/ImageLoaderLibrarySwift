//
//  HomeTableViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation
import UIKit

class ComicsViewModel {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Comic>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Comic>
    var activityIndicator = UIActivityIndicatorView()

   
    var comicbooks: [Comic]? = []
    weak var delegate: ViewModelDelegate?
    
    func comicCellViewModel(at indexPath: IndexPath) -> ComicCellViewModel {
        let comic = comicbooks?[indexPath.row]
        let viewModel = ComicCellViewModel(comic: comic)
        return viewModel
    }
    
    @MainActor func applySnapshot(animatingDifferences: Bool = true, dataSource: DataSource) {
         var snapshot = Snapshot()
         snapshot.appendSections([.main])
         snapshot.appendItems(comicbooks!, toSection: .main)
         dataSource.apply(snapshot, animatingDifferences: true)
         print("snapshot applied")
     }
    
    func loadData(completion: @escaping (Bool) -> Void) {
        let request = URL(string: generatedURL)!
        Task{
            do{
                try await downloadObject(url: request, completionHandler: { result in
                    switch result {
                    case .success(let result):
                        self.comicbooks = result.data?.comicbooks
                        completion(true)
                        Task{
                            await self.delegate?.reloadTable()
                        }
                    case .failure(let error):
                        print(error)
                        completion(false)
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
            }else {
                print("API Call not successful")
                completionHandler(.failure(InternetError.noInternet))
            }
        }
        task.resume()
    }
}


