//
//  FlagViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 25/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit
import WebKit

final class FlagViewController: BaseViewController {

    // MARK: - UI

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleToFill
        return webView
    }()

    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureConstraints()
    }

    private func configureConstraints() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func updateData(country: Country) {
        title = country.name
        if let url = country.flag {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
