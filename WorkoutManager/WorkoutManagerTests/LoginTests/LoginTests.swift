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
    private weak var mockViewModelDelegate:MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        
        self.viewModel = LoginViewModel(delegate: MockViewModelDelegate())
    }
    
    func checkLoginDetailsPass() {
        XCTAssertTrue(viewModel.checkLoginDetails(username: "Admin", password: "TestPass123"))
    }
    func checkLoginDetailsFail() {
        XCTAssertTrue(viewModel.checkLoginDetails(username: "Admin", password: "TestPas"))
    }
    
    func testLoginPass() {
        XCTAssertTrue(viewModel.checkLoginDetails(username: "Admin", password: "TestPass123"))
    }
    func testLoginFail() {
        viewModel.loginUser(with: "ASdf", and: "afsdf")
    }
    
    class MockViewModelDelegate: ViewModelDelegate {
        
        func showError(error: String) {
            
        }
        
        func navigateToPage(itemIndex: Int?) {
            
        }
    }

}
