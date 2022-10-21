//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Luka Lešić on 19.10.2022..
//

import XCTest
@testable import MVVM

final class MVVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testSum() throws {
            
        let viewController = Calculator()
        
        let result = viewController.sum(a: 5, b: 5)
        XCTAssertEqual(result, 10)
    }

}
