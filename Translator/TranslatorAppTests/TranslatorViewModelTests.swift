//
//  TranslatorViewModelTests.swift
//  TranslatorAppTests
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import XCTest
@testable import Translator

final class TranslatorViewModelTests: XCTestCase {
    
    var viewModel: TranslatorViewModel!

    override func setUpWithError() throws {
        viewModel = TranslatorViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testGetRandomPhrase() {
        let phrase = viewModel.getRandomPhrase()
        XCTAssertFalse(phrase.isEmpty, "The phrase must not be empty")
    }
    
}
