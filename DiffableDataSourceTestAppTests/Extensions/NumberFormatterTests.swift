//
//  NumberFormatterTests.swift
//  DiffableDataSourceTestAppTests
//
//  Created by Goran Tokovic on 26/06/2020.
//  Copyright © 2020 Goran Tokovic. All rights reserved.
//

@testable import DiffableDataSourceTestApp
import XCTest

class NumberFormatterTests: XCTestCase {
    func testSeparatedHundreds() {
        XCTAssertEqual(NumberFormatter.separatedHundreds.string(from: NSNumber(value: 123456789.23)), "123 456 789")
        XCTAssertEqual(NumberFormatter.separatedHundreds.string(from: NSNumber(value: 123456789.234334)), "123 456 789")
        XCTAssertEqual(NumberFormatter.separatedHundreds.string(from: NSNumber(value: 1234.234334)), "1 234")
    }

//    func testFalling() {
//        XCTAssertTrue(false, "Falling test")
//    }
}
