//
//  LoginViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/02/28.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var userNameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    private lazy var viewModel = LoginViewModel(delegate:self)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userNameField.delegate = self
        passwordField.delegate = self
    }
 
    @IBAction private func enterTapped(_ sender: Any) {
        guard let password = passwordField.text ,
              let username = userNameField.text else { return }
        
        if viewModel.checkLoginDetails(username: password, password: username) {
            navigateToPage()
            
        } else {
            showError(error: "Incorrect details")
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension LoginViewController:ViewModelDelegate {
    func navigateToPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: WorkoutManagerViewController.identifier) as?
            WorkoutManagerViewController {
            viewController.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func showError(error: String) {
        showAlert(title: "Error", message: error, buttonTitle: "Retry")
    }
}
