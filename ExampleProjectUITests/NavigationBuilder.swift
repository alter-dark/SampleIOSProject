//
//  NavigationBuilder.swift
//  ExampleProjectUITests
//
//  Created by Aylwing Olivas on 4/29/22.
//

import Foundation
import XCTest

public final class NavigationBuilder {
    let app: XCUIApplication
    
    public init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func wait(element: SampleIdentification, timeout: Int = 10) -> NavigationBuilder {
        let element = app.getElement(element)
        XCTAssertTrue(element.waitForExistence(timeout: 10), "\(element.identifier) not found")
        return self
    }
    
    @discardableResult
    func tap(element: SampleIdentification) -> NavigationBuilder {
        app.getElement(element).tap()
        return self
    }
    
    @discardableResult
    func type(element: SampleIdentification, text: String) -> NavigationBuilder {
        let element = app.getElement(element)
        element.typeText(text)
        return self
    }
}

public extension XCUIApplication {
    internal func getElement(_ element: SampleIdentification) -> XCUIElement {
        let elementType = XCUIElement.ElementType(rawValue: element.type.rawValue) ?? .any
        return descendants(matching: elementType)[element.identifier].firstMatch
    }
}
