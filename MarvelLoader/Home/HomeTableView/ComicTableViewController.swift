//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit


class ComicTableViewController: UIViewController, ViewModelDelegate {
        
    var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
    private var comicsViewModel = ComicsViewModel()
    
    private lazy var dataSource = makeDataSource()
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Comic>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Comic>

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Loader"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        tableView.dataSource = dataSource
        comicsViewModel.loadData()
        configureTableView()
    }
    
    func makeDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, _  in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: Cells.comicCell,
                    for: indexPath) as? ComicCell
                                
                let cellViewModel = self.comicsViewModel.comicCellViewModel(at: indexPath)
                cell!.updateWith(viewModel: cellViewModel)
                return cell
            })
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.configureForAutoLayout()
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
       setTableViewDelegates()
        tableView.register(ComicCell.self, forCellReuseIdentifier: Cells.comicCell)
    }
    
    func setTableViewDelegates(){
        comicsViewModel.delegate = self
        tableView.delegate = self
    }
}

extension ComicTableViewController {
    
    func reloadTable() async {
        await MainActor.run {
            self.comicsViewModel.applySnapshot(animatingDifferences: true, dataSource: self.dataSource)
        }
    }
}

extension ComicTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       guard let comic = dataSource.itemIdentifier(for: indexPath) else {
          return
        }

        let detailVM = DetailViewModel(comic: comic)
        let detailView = DetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



