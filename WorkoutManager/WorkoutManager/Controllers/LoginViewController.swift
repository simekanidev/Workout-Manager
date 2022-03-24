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
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
        passwordField.delegate = self
    }
 
    @IBAction private func enterTapped(_ sender: Any) {
        guard let password = passwordField.text ,
                let username = userNameField.text else { return }
        
        if username == "Admin" && password == "TestPass123" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "WorkoutManagerViewController") as?
                WorkoutManagerViewController {
                viewController.navigationItem.setHidesBackButton(true, animated: false)
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        } else {
            let alert = UIAlertController(title: "Incorrect details", message: "incorrect Username/Password enteres", preferredStyle: UIAlertController.Style.alert)
            
                    alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
        
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
