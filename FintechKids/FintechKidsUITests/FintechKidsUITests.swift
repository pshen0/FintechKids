//
//  FintechKidsUITests.swift
//  FintechKidsUITests
//
//  Created by Михаил Прозорский on 26.03.2025.
//
import XCTest

final class CardsGameUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testNavigationToCardsGame() {
        // Given
        sleep(4)
        let cardsGameButton = app.buttons["Игра Карточки"]
        
        // When
        cardsGameButton.tap()
    }
    
}
