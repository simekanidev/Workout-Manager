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
    private var mockViewModel:MockViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockViewModel = MockViewModelDelegate()
        self.viewModel = LoginViewModel(delegate: mockViewModel)
    }
    
    func testLoginPass() {
       viewModel.loginUser(with: "Admin", and: "TestPass123")
        XCTAssertTrue(mockViewModel.navigateToPageCalled)
    }
    func testLoginIncorrectUsernameAndPassword() {
        viewModel.loginUser(with: "ASdf", and: "afsdf")
        XCTAssertFalse(mockViewModel.navigateToPageCalled)
    }
    
    func testLoginIncorrectPassword() {
       viewModel.loginUser(with: "Admin", and: "TestPass12")
        XCTAssertFalse(mockViewModel.navigateToPageCalled)
    }
    func testLoginIncorrectUsername() {
        viewModel.loginUser(with: "Adm", and: "TestPass12")
        XCTAssertFalse(mockViewModel.navigateToPageCalled)
    }
    
    class MockViewModelDelegate: ViewModelDelegate {
        var showErrorCalled = false
        var navigateToPageCalled = false
        func showError(error: String) {
            showErrorCalled = true
        }
        
        func navigateToPage(itemIndex: Int?) {
            navigateToPageCalled = true
        }
    }

}
