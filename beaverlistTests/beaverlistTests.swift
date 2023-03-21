//
//  beaverlistTests.swift
//  beaverlistTests
//
//  Created by Sara on 19/03/2023.
//

import XCTest
import UIKit
import SwiftUI

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
}
