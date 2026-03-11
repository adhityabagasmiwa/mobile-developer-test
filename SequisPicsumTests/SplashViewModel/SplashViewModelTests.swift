//
//  SplashViewModelTests.swift
//  SequisPicsumTests
//
//  Created by Adhitya Bagasmiwa Permana on 11/03/26.
//

import XCTest
@testable import SequisPicsum

final class SplashViewModelTests: XCTestCase {
    var sut: SplashViewModel!
    
    override func setUp() {
        super.setUp()
        sut = SplashViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_start_shouldSetIsFinishedToTrueAfterDelay() {
        // Given
        let expectation = XCTestExpectation(description: "Splash should finish")
        
        // When
        sut.start()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            if self.sut.isFinished {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.5)
    }
}
