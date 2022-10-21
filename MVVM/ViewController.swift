//
//  ViewController.swift
//  MVVM
//
//  Created by Luka Lešić on 19.10.2022..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    private func test() {
        
        let calculator = Calculator()
        calculator.sum(a: 5, b: 5)
    }
}

