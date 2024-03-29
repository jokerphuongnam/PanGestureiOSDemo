//
//  PanGestureDemoUITestsLaunchTests.swift
//  PanGestureDemoUITests
//
//  Created by gannha on 19/01/2022.
//

import XCTest

class PanGestureDemoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testPanGesture() throws {
        let app = XCUIApplication()
        app.launch()
        app.otherElements["panView"].swipeUp()
    }
}
