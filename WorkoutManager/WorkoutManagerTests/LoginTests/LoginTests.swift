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
        mockViewModelDelegate = MockViewModelDelegate()
        self.viewModel = LoginViewModel(delegate: mockViewModelDelegate)
    }
    
    func checkLoginDetailsPass() {
        viewModel.loginUser(with: "Admin", and: "TestPass123")
        
    }
    func checkLoginDetailsFail() {
        viewModel.loginUser(with: "Admin", and: "TestPas")
    }
    
    func testLoginPass() {
       viewModel.loginUser(with: "Admin", and: "TestPass123")
    }
    func testLoginFail() {
        viewModel.loginUser(with: "ASdf", and: "afsdf")
    }
    
    class MockViewModelDelegate: ViewModelDelegate {
        var showErrorCalled = false
        var navigateToPageCalled = false
        func showError(error: String) {
            showErrorCalled = true
        }
        
        func navigateToPage(itemIndex: Int?) {
            showErrorCalled = false
        }
    }

}
