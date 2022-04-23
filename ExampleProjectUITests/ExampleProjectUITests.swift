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
    override func setUp() {
        super.setUp()
        app.launchTunnel()
        /* app.launchTunnel(withOptions: [SBTUITunneledApplicationLaunchOptionResetFilesystem]) {
            // do additional setup before the app launches
            // i.e. prepare stub request, start monitoring requests
        } */
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
        // Stubs work here as well
        // self.app.stubRequests(matching: SBTRequestMatch(url: "httpbin.org"), response: SBTStubResponse(response: ["stubbed": 1]))
        
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

    func testLogicSuccess() throws {
        // UI tests must launch the application that they test.
        /* let app = XCUIApplication()
        app.launch() */
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        /* let app = XCUIApplication()
        app.launch() */
    
        // XCTAssertTrue(app.navigationBars["LoginVC"].exists)
        
        let usernameTextField = app.textFields["Username"]
        // XCTAssertTrue(usernameTextField.exists)
        usernameTextField.tap()
        usernameTextField.typeText("darky")
        
        let passTextField = app.textFields["Password"]
        // XCTAssertTrue(passTextField.exists)
        passTextField.tap()
        passTextField.typeText("dk2022@")
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Log in"]/*[[".buttons[\"Log in\"].staticTexts[\"Log in\"]",".staticTexts[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
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
