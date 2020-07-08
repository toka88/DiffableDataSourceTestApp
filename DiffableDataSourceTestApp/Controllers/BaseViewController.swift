//
//  BaseViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 03/07/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()




        view.backgroundColor = .background
        let array = [1, 2, 4, 5,6,7]
        if array.count > 0 {
            print("Goran Tokovic")
            
        }
    }
}
