//
//  UIViewControllerExtension.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
