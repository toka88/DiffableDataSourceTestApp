//
//  CountrySplitViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 25/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit

final class CountrySplitViewController: UISplitViewController {
    private lazy var flagController: FlagViewController = FlagViewController()
    private lazy var detailsNavigationController: UINavigationController = UINavigationController(rootViewController: flagController)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let masterNC = UINavigationController(rootViewController: CountriesViewController(delegate: self))
        masterNC.view.backgroundColor = .black
        let detailNC = UINavigationController(rootViewController: EmptyViewController())
        viewControllers = [masterNC, detailNC]
        view.backgroundColor = .background
        preferredDisplayMode = .allVisible
    }
}

extension CountrySplitViewController:  CountriesViewControllerDelegate {
    func selectedCountry(_ country: Country) {
        showDetailViewController(detailsNavigationController, sender: nil)
        flagController.updateData(country: country)
    }
}
