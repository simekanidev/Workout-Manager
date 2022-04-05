//
//  LoginViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/23.
//

import Foundation

protocol ViewModelDelegate:AnyObject {
    func showError(error:String)
    func navigateToPage(itemIndex:Int?)
}

class LoginViewModel {
    private weak var delegate: ViewModelDelegate?
    
    init(delegate:ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loginUser(with username: String, and password:String) {
        self.checkLoginDetails(username: username, password: password)
        ? delegate?.navigateToPage(itemIndex : nil) : delegate?.showError(error: "Incorrect Login Details")
    }
    
    func checkLoginDetails(username:String, password:String) -> Bool {
        return username == "Admin" && password == "TestPass123"
    }
}
