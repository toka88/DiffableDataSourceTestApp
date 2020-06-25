////////////////////////////////////////////////////////////////////////////////
//
// Prod-Active Solutions Kravolution
// Copyright (c) 2020 Prod-Active Solutions
// All Rights Reserved Worldwide
// Proprietary and Confidential - Not for Distribution
// Written by Prod-Active Solutions.
//
// UITableView.swift
//
// AUTHOR IDENTITY:
//        Goran Tokovic        14/04/2020
//
////////////////////////////////////////////////////////////////////////////////
import UIKit
////////////////////////////////////////////////////////////////////////////////
extension UITableView {

    /**
     Registers a cell class with the table view using the class's default reuse identifier.
     */
    func registerCellClass(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier)
    }

    /**
     Dequeues and returns a cell of the specified class, using the cell class's default reuse identifier.
     */
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Incorrect type for dequeued cell with identifier: \(cellClass.defaultReuseIdentifier)")
        }

        return cell
    }
}
