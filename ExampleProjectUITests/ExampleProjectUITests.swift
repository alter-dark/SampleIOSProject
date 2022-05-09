//
//  ExampleProjectUITests.swift
//  ExampleProjectUITests
//
//  Created by John on 4/16/22.
//

import Foundation
import SBTUITestTunnelClient
import XCTest

class ExampleProjectUITests: XCTestCase {
    
    let LoginButton = SampleIdentification(
        accessibilityIdentifier: "login_button", elemenType: .button)
    
    let PassWordElement = SampleIdentification(
        accessibilityIdentifier: "login_password_textfield", elemenType: .textField)
    
    let UserNameElement = SampleIdentification(
        accessibilityIdentifier: "login_username_textfield", elemenType: .textField)
    
    override func setUp() {
        super.setUp()
        app.launchTunnel()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func json(utf8Data: Data) -> [String: Any] {
        return ((try? JSONSerialization.jsonObject(with: utf8Data, options: [])) as? [String: Any]) ?? [:]
    }
    
    func testStubWithFile() throws {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "expected", ofType: "json") else { return
        }
        let jsonContent = try? String(contentsOfFile: path)
        
        let data = Data(jsonContent!.utf8)
        let mockedResponse = json(utf8Data: data)
        // Stub with the json
        app.stubRequests(matching: SBTRequestMatch(url: "httpbin.org"), response: SBTStubResponse(response: mockedResponse))
        
        XCTAssertFalse(app.stubRequestsAll().isEmpty)
        
        let getButton = app.staticTexts["GET"]
        XCTAssertTrue(getButton.exists)
        getButton.tap()
        
        let responseTextField = app.textViews["RequestDone"]
        let exists = responseTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(exists)
        
        let actualText = responseTextField.value as! String
        let actualData = Data(actualText.utf8)
        
        let actualResponse = NSDictionary(dictionary: json(utf8Data: actualData))
        
        XCTAssertTrue(actualResponse.isEqual(to: mockedResponse))
    }
    
    func testStubSimpleURL() throws {
        self.app.stubRequests(matching: SBTRequestMatch(url: "httpbin.org"), response: SBTStubResponse(response: ["stubbed": 1]))
        
        let getButton = app.staticTexts["GET"]
        XCTAssertTrue(getButton.exists)
        getButton.tap()
        
        let responseTextField = app.textViews["RequestDone"]
        let exists = responseTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(exists)
        
        let expectedText = "{\"stubbed\":1}"
        let actualText = responseTextField.value as! String
        
        XCTAssertEqual(expectedText, actualText, "Request is not being stubbed")
    }

    func testLoginSuccess() throws {
        NavigationBuilder(app: app)
            .wait(element: UserNameElement)
            .tap(element: UserNameElement)
            .type(element: UserNameElement, text: "darky")
        
        NavigationBuilder(app: app)
            .wait(element: PassWordElement)
            .tap(element: PassWordElement)
            .type(element: PassWordElement, text: "dk2022@")

        NavigationBuilder(app: app)
            .wait(element: LoginButton)
            .tap(element: LoginButton)
        
        XCTAssertTrue(app.navigationBars["Welcome to your dashboard"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
