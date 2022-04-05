//
//  LoginTests.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/05.
//

import XCTest
@testable import WorkoutManager

class LoginTests: XCTestCase {
    
    private var viewModel: LoginViewModel!
    private var mockViewModelDelegate:MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        
        self.viewModel = LoginViewModel(delegate: MockViewModelDelegate())
    }
    
    func testLoginPass() {
        XCTAssertTrue(viewModel.checkLoginDetails(username: "Admin", password: "TestPass123"))
    }
    func testLoginFail() {
        XCTAssertTrue(viewModel.checkLoginDetails(username: "Admin", password: "TestPas"))
    }
    
    class MockViewModelDelegate: ViewModelDelegate {
        func showError(error: String) {
            print("Show Error")
        }
        
        func navigateToPage(itemIndex: Int?) {
            print("Navigating to page")
        }
    }

}
