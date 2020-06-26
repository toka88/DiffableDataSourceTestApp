//
//  CountriesControllerViewController.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 24/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import UIKit

protocol CountriesViewControllerDelegate: class {
    func selectedCountry(_ country: Country)
}

private extension CountriesViewController {
    enum Sections {
        case main
    }
}

final class CountriesViewController: UIViewController {

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.registerCellClass(CountryCellTableViewCell.self)
        return tableView
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Country"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        return searchController
    }()

    // MARK: - Data

    private weak var delegate: CountriesViewControllerDelegate?
    private var dataSource: UITableViewDiffableDataSource<Sections, Country>!
    private var countries: [Country] = []
    private var filteredCountries: [Country] = [] {
        didSet {
            var snapshot = NSDiffableDataSourceSnapshot<Sections, Country>()
            snapshot.appendSections([.main])
            snapshot.appendItems(filteredCountries, toSection: .main)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }

    init(delegate: CountriesViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
        loadCountries()
    }

    private func configureUI() {
        title = NSLocalizedString("Countries", comment: "")
        navigationItem.searchController = searchController

        view.addSubview(tableView)
        tableView.pinToSafeArea(ofView: view)
    }

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, country) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(CountryCellTableViewCell.self, for: indexPath)
            cell.updateData(country)
            return cell
        })
    }

    // MARK: - Helpers

    private func loadCountries() {
        guard let data = readLocalFile(forName: "countries") else {
            return
        }

        do {
            countries = try JSONDecoder().decode([Country].self, from: data)
            filteredCountries = countries
        } catch  {
            debugPrint(error)
        }
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }
}

// MARK: - UITableViewDelegate

extension CountriesViewController: UITableViewDelegate { 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let country = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        delegate?.selectedCountry(country)
    }
}

// MARK: - UISearchBarDelegate

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCountries = countries
            return
        }

        filteredCountries = countries.filter({ country -> Bool in
            return country.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
    }
}
