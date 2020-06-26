//
//  CountrySplitViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 25/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit

final class CountrySplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let masterNC = UINavigationController(rootViewController: CountriesViewController(delegate: self))
        masterNC.view.backgroundColor = .black
        let detailNC = UINavigationController(rootViewController: EmptyViewController())
        viewControllers = [masterNC, detailNC]
    }
}

extension CountrySplitViewController: CountriesViewControllerDelegate {
    func selectedCountry(_ country: Country) {
        let nc = viewControllers[1] as! UINavigationController
        var flagVC = nc.viewControllers[0] as? FlagViewController
        if flagVC == nil {
            flagVC = FlagViewController()
            nc.viewControllers[0] = flagVC!
        }
        flagVC?.updateData(country: country)
    }
}
