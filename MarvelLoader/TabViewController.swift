//
//  ViewController.swift
//  MarvelLoader
//
//  Created by Luka Lešić on 04.10.2022..
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let homeViewController = UINavigationController(rootViewController: HomeTableViewController())
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.title = "Home"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeViewController] , animated: true)
    }


}

