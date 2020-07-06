//
//  EmptyViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 25/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit

final class EmptyViewController: BaseViewController {
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Not selected country", comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .text
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(infoLabel)
        infoLabel.pinToSafeArea(ofView: view)
    }
}
