//
//  HomeTableViewModel.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 20.10.2022..
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func reloadTable()
}

class HomeTableViewModel {
    
    var comic: ComicBookBaseData?
    weak var delegate: ViewModelDelegate?

    @Published var comicBook: ComicBookBaseData?

    func loadData() async  {
        let request = URL(string: generatedURL)!
        
        do{
            try await downloadObject(url: request, completionHandler: { result in
                switch result {
                case .success(let result):
                    self.comic =  result as ComicBookBaseData
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
    

