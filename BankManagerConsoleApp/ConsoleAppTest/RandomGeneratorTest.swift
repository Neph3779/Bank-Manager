//
//  RandomGeneratorTest.swift
//  ConsoleAppTest
//
//  Created by 천수현 on 2021/05/03.
//

import XCTest

class RandomGeneratorTest: XCTestCase {
    var sut: RandomGenerator!
    
    override func setUpWithError() throws {
        sut = RandomGenerator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_generateRandomCustomer_호출시_비어있지_않은_Customer_배열을_반환하는지() {
        let result = sut.generateRandomCustomer()
        XCTAssert(!result.isEmpty)
    }
}
