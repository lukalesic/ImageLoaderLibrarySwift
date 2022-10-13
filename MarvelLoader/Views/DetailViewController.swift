//
//  DetailViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 11.10.2022..
//

import UIKit

class DetailViewController: UIViewController {
    
    var presentation = DetailPresentation()
    var comicDetail: Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        title = "Details"
        setup()
    }
    
    private func setup(){
        presentation.controller = self
        presentation.displayLayout()
    }
   
}
