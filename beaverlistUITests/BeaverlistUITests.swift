//
//  BeaverlistUITests.swift
//  BeaverlistUITests
//
//  Created by Sara on 19/03/2023.
//

import XCTest

class BeaverlistUITests: XCTestCase {

    override func setUpWithError() throws {
            continueAfterFailure = false
            let app = XCUIApplication()
            app.launch()
        }

        func testSearchWithNoResults() throws {
            let app = XCUIApplication()
            let searchField = app.searchFields.firstMatch
            app.searchFields["Search"].tap()
            searchField.typeText("76")
            app.staticTexts["No results found for '76' 🦫"].tap()

        }

        func testSearchWithResults() throws {
            let app = XCUIApplication()
            let searchField = app.searchFields.firstMatch
            searchField.tap()
            searchField.typeText("Japan")
            app.staticTexts["This line includes a word from the Japanese writing system: こんにちは"].tap()
        }

    func testThemesMenu() throws {
        let app = XCUIApplication()
        let themesButton = app.buttons["themes"]
        themesButton.tap()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Blueberry Blush"]/*[[".cells.buttons[\"Blueberry Blush\"]",".buttons[\"Blueberry Blush\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        themesButton.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Slate Mist"]/*[[".cells.buttons[\"Slate Mist\"]",".buttons[\"Slate Mist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        themesButton.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Mystic Twilight"]/*[[".cells.buttons[\"Mystic Twilight\"]",".buttons[\"Mystic Twilight\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        themesButton.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Sunset Blaze"]/*[[".cells.buttons[\"Sunset Blaze\"]",".buttons[\"Sunset Blaze\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testDismissSearch() throws {
        let app = XCUIApplication()
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("test dismissing search")
        searchField.buttons["Clear text"].tap()
        searchField.typeText("test dismissing search - cancel")
        app/*@START_MENU_TOKEN@*/.staticTexts["Cancel"]/*[[".buttons[\"Cancel\"].staticTexts[\"Cancel\"]",".staticTexts[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testShowToast() throws {
        let app = XCUIApplication()
        app.staticTexts["This string contains trademark symbol: ™"].tap()
        // Check if the toast is displayed
        app.staticTexts["Copied to clipboard"].tap()
    }

    func testCopyToClipboard() {
        let app = XCUIApplication()
        app.staticTexts["This string contains trademark symbol: ™"].tap()
        // Assert that the correct text was copied to the clipboard
        XCTAssertEqual(UIPasteboard.general.string, "™")
    }
}
