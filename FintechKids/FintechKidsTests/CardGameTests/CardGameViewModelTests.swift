//
//  CardGameViewModelTests.swift
//  FintechKidsTests
//
//  Created by Margarita Usova on 03.04.2025.
//

import XCTest
@testable import FintechKids

final class CardGameViewModelTests: XCTestCase {

    var viewModel: CardGameViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let screenFactory = ScreenFactory()
        viewModel = CardGameViewModel(screen: .cardsGame, screenFactory: screenFactory)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        super.tearDown()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIsCloseEnough() {
            // Устанавливаем тестовую карточку с известной ценой
            viewModel.currentRoundCards = [CardGameRound(name: "Test Card", imageName: "test", cost: 100)]
            viewModel.currentCardIndex = 0
            
            // число в пределах 70-130 возвращает true
            XCTAssertTrue(viewModel.isCloseEnough(100))
            XCTAssertTrue(viewModel.isCloseEnough(130))
            XCTAssertTrue(viewModel.isCloseEnough(70))

            // числа за пределами диапазона возвращают false
            XCTAssertFalse(viewModel.isCloseEnough(69))
            XCTAssertFalse(viewModel.isCloseEnough(131))
        }

        func testGetFeedback() {
            viewModel.currentRoundCards = [CardGameRound(name: "Test Card", imageName: "test", cost: 100)]
            viewModel.currentCardIndex = 0
            
            XCTAssertEqual(viewModel.getFeedback(for: 100), "Почти правильно! 🎉 Верный ответ: 100")
            XCTAssertEqual(viewModel.getFeedback(for: 130), "Почти правильно! 🎉 Верный ответ: 100")
            XCTAssertEqual(viewModel.getFeedback(for: 70), "Почти правильно! 🎉 Верный ответ: 100")
            
            XCTAssertEqual(viewModel.getFeedback(for: 140), "Слишком дорого! Попробуй снова.")
            XCTAssertEqual(viewModel.getFeedback(for: 60), "Слишком дешево! Попробуй снова.")
        }

}
