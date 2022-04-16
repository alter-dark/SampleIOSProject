//
//  SimpleCalculatorTests.swift
//  ExampleProjectTests
//
//  Created by John on 4/16/22.
//

import Foundation
import XCTest

@testable import ExampleProject

class SimpleCalculatortest : XCTestCase {
    var sut = SimpleCalculator()
    
    func testCalculatorIsNotNil() {
        XCTAssertNotNil(sut, "SUT must not be null")
    }
    
    func testCanSubtract() {
        let result = sut.subtract(a: 3, b: 5)
        XCTAssertEqual(result, 4)
    }
    
    func testCanMultiply() {
        let result = sut.multiply(a: 5, b: 5)
        XCTAssertEqual(result, 25)
    }
}
