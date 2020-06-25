//
//  FlagViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 25/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit
import WebKit

final class FlagViewController: UIViewController {

    // MARK: - UI

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleToFill
        return webView
    }()

    // MARK: - Data

    private let flagURL: URL

    // MARK: - Init

    init(flagURL: URL, name: String?) {
        self.flagURL = flagURL
        super.init(nibName: nil, bundle: nil)
        title = name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureConstraints()
        view.backgroundColor = .white
        let request = URLRequest(url: flagURL)
        webView.load(request)
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
}
