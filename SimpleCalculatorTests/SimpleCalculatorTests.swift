//
//  SimpleCalculatorTests.swift
//  SimpleCalculatorTests
//
//  Created by John on 4/17/22.
//

import XCTest
@testable import ExampleProject

class SimpleCalculatorTests: XCTestCase {
    var sut = SimpleCalculator()
    
    func testCalculatorIsNotNil() {
        XCTAssertNotNil(sut, "SUT must not be null")
    }
    
    func testCanSubtract() {
        let result = sut.subtract(a: 9, b: 5)
        XCTAssertEqual(result, 4)
    }
    
    func testCanMultiply() {
        let result = sut.multiply(a: 5, b: 5)
        XCTAssertEqual(result, 25)
    }
}
