//
//  HomeTableViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation
import UIKit
import Combine

enum State {
  case empty
  case loading
  case error(error: Error)
  case populated
}

enum NetworkError: Error {
    case noConnection
    case invalidServerResponse
    case custom
    case parsingFailure
}


extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection:
            return NSLocalizedString("No Internet connection available.", comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Invalid server response.", comment: "")
        case .custom:
            return NSLocalizedString("An error has occurred.", comment: "")
        case .parsingFailure:
            return NSLocalizedString("A data parsing error had occured. Please try again", comment: "")
        }
    }
}


class ComicsViewModel {
    
    @Published private(set) var state: State = .empty
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Comic>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Comic>
    let decode = JSONDecoder()

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
    
    func loadData() {
        state = .loading
        let request = URL(string: generatedURL)!
        downloadObject(url: request, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.comicbooks = result.data?.comicbooks
                   
                    self.delegate?.reloadTable()
                    
                    self.state = .populated
                    
                case .failure(let error):
                    print(error)
                    self.state = .error(error: error)
                }
            }
        })
    }
    
    func downloadObject(url: URL, completionHandler: @escaping (Result<ComicBookBaseData, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completionHandler(.failure(NetworkError.custom))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(NetworkError.invalidServerResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.parsingFailure))
                return
            }
            
            do{
                    let result = try self.decode.decode(ComicBookBaseData.self, from: data)
                    print("data loaded!!")
                    completionHandler(.success(result))
            }
            catch{
                print(error)
                completionHandler(.failure(NetworkError.parsingFailure))
            }
        }
        .resume()
    }
}


