//
//  Country.swift
//  DiffableDataSourceTestApp
//
//  Created by Goran Tokovic on 24/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

import Foundation

struct Country: Codable, Hashable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }

    let name: String?
    let alpha2Code: String?
    let capital: String?
    let population: Int?
    let flag: URL?
}
