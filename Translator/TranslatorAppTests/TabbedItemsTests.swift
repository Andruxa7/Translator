//
//  TabbedItemsTests.swift
//  TranslatorAppTests
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import XCTest
@testable import Translator

final class TabbedItemsTests: XCTestCase {

    func testTabTitles() {
        XCTAssertEqual(TabbedItems.translator.title, "Translator")
        XCTAssertEqual(TabbedItems.clicker.title, "Clicker")
    }
    
    func testTabIcons() {
        XCTAssertEqual(TabbedItems.translator.iconName, "messages")
        XCTAssertEqual(TabbedItems.clicker.iconName, "gear")
    }

}
