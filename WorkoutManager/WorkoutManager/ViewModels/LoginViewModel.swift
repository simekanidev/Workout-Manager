//
//  LoginViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/23.
//

import Foundation
import UIKit
protocol ViewModelDelegate:AnyObject {
    func showError(error:String)
    func navigateToPage()
    
}

class LoginViewModel {
    private weak var delegate: ViewModelDelegate?
    
    init(delegate:ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func checkLoginDetails(username:String, password:String) -> Bool {
        if username == "Admin" && password == "TestPass123" {
            return true
        }
        return false
    }
}
