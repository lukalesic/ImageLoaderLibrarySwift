//
//  DetailViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 11.10.2022..
//

import UIKit

class DetailViewController: UIViewController {
    
    var presentation = DetailPresentation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character View"
        setup()
    }
    
    private func setup(){
        presentation.controller = self
        presentation.displayLayout()
    }
   
}
