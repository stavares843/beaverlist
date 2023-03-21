//
//  beaverlistTests.swift
//  beaverlistTests
//
//  Created by Sara on 19/03/2023.
//

import SwiftUI
import UIKit
import XCTest

@testable import Beaverlist

class ContentViewTests: XCTestCase {

  // Test case to verify if the view is rendered
  func testContentView_Rendered() {
    let contentView = ContentView()
    let hostingController = UIHostingController(rootView: contentView)
    XCTAssertNotNil(hostingController.view)
  }

  // Test case to verify if the user inputs are loaded correctly from the txt file
  func testContentView_UserInputsLoaded() {
    let contentView = ContentView()
    XCTAssertFalse(contentView.userInputs.isEmpty)
  }

  // Test case to verify if the search functionality is working correctly
  func testContentView_SearchFunctionality() {
    let contentView = ContentView()
    contentView.searchText = "input"
    XCTAssertFalse(contentView.filteredUserInputs.isEmpty)
  }

  // Test case to verify initial state of ContentView properties
  // such as searchText, isTapped, showToast, userInputs and filteredUserInputs.
  func test_ContentView() {
    let contentView = ContentView()
    XCTAssertEqual(contentView.searchText, "")
    XCTAssertFalse(contentView.isTapped)
    XCTAssertFalse(contentView.showToast)
    XCTAssertGreaterThan(contentView.userInputs.count, 0)
    XCTAssertGreaterThan(contentView.filteredUserInputs.count, 0)
  }

  // Test case to verify if the filtering of user inputs is working as expected.
  // It checks if the filtered user inputs count is equal to the actual user inputs count before filtering,
  // and if the count changes after applying a search text.
  // It also checks if all the filtered user inputs contain the search text in a case-insensitive manner.
  func test_filteredUserInputs() {
    let contentView = ContentView()
    let filteredUserInputs = contentView.filteredUserInputs
    XCTAssertEqual(filteredUserInputs.count, contentView.userInputs.count)
    contentView.searchText = "test"
    XCTAssertNotEqual(filteredUserInputs.count, contentView.userInputs.count)
    XCTAssertTrue(
      filteredUserInputs.allSatisfy { $0.localizedCaseInsensitiveContains(contentView.searchText) })
  }
}
