//
//  ConsoleViewControllerTest.swift
//  ConsoleAppTest
//
//  Created by 천수현 on 2021/05/04.
//

import XCTest

class ConsoleViewControllerTest: XCTestCase {
    var sut: ConsoleViewController!
    
    override func setUpWithError() throws {
        sut = ConsoleViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_userInput이_1일때_shouldContinue의_반환값이_success_true인지() {
        // given
        let userInput = "1"
        // when
        let result = sut.shouldContinue(input: userInput)
        // then
        XCTAssertEqual(result, .success(true))
    }
    
    func test_userInput이_2일때_shouldContinue의_반환값이_success_false인지() {
        // given
        let userInput = "2"
        // when
        let result = sut.shouldContinue(input: userInput)
        // then
        XCTAssertEqual(result, .success(false))
    }
    
    func test_userInput이_1과_2가_아닐때_shouldContinue의_반환값이_failure이고_invalidUserInput_error을_반환하는지() {
        // given
        let userInput = ""
        // when
        let result = sut.shouldContinue(input: userInput)
        // then
        XCTAssertEqual(result, .failure(.invalidUserInput))
    }
}
