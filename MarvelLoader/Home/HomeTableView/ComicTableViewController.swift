//
//  HomeTableViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 05.10.2022..
//

import UIKit


class ComicTableViewController: UIViewController, ViewModelDelegate {
    
    let errorMessage = UILabel()
    var refreshControl = UIRefreshControl()
    let refreshButton = UIButton(type: .system)
        
    var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
    private var comicsViewModel = ComicsViewModel()
    
    private lazy var dataSource = makeDataSource()
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Comic>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Comic>

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel Loader"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        configureTableView()
        tableView.dataSource = dataSource
        
        activityIndicator.startAnimating()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControl.Event.valueChanged)
        comicsViewModel.loadData { success in
            switch success {
            case true:
                self.activityIndicator.stopAnimating()
                
            case false:
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.errorMessage.text = "No internet connection available"
                    self.setupButton()
                }
                
            }
        }
    }
    
    @objc func refreshTable(send: UIRefreshControl){
        Task {
            self.errorMessage.isHidden = true
            self.refreshButton.isHidden = true
            activityIndicator.startAnimating()
            self.comicsViewModel.loadData{_ in
                self.activityIndicator.stopAnimating()

            }
            await reloadTable()
            self.refreshControl.endRefreshing()
        }
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
        tableView.addSubview(activityIndicator)
        tableView.addSubview(errorMessage)
        tableView.addSubview(refreshButton)
        tableView.addSubview(refreshControl)
        refreshButton.autoCenterInSuperview()
       errorMessage.autoPinEdge(.bottom, to: .top, of: refreshButton, withOffset: -15)
        errorMessage.autoAlignAxis(.vertical, toSameAxisOf: refreshButton, withOffset: 0)
        activityIndicator.configureForAutoLayout()
        activityIndicator.autoCenterInSuperview()

        activityIndicator.color = UIColor.red

        tableView.configureForAutoLayout()
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
       setTableViewDelegates()
        tableView.register(ComicCell.self, forCellReuseIdentifier: Cells.comicCell)
    }
    
    func setTableViewDelegates(){
        comicsViewModel.delegate = self
        tableView.delegate = self
    }
    
    func setupButton() {
        refreshButton.isHidden = false
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.configureForAutoLayout()
        refreshButton.backgroundColor = UIColor.systemRed
        refreshButton.autoSetDimensions(to: CGSize(width: 70, height: 40))
        refreshButton.setTitleColor(UIColor.white, for: .normal)
        refreshButton.layer.cornerRadius = 6
        refreshButton.addTarget(self, action: #selector(self.refreshTable), for: .touchUpInside)

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



