//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/02/23.
//

import UIKit

class UserViewController: UIViewController {
    
    // Creates an array of users that we can reference the data
    private var userUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Calls the function that will execute get users api call
        getUserDetails()
    }
    
    // Function that will handle the logic for requesting the api call
    func getUserDetails() {
        let url = Constants.baseURL?.appendingPathComponent("userprofile/")
        // Asks the url session to make a call to our custom function
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:User.self, completion: {result in
            
            // Swift the state of the result
            switch result {
            case .success(let userArray):
                print(userArray)
            case .failure(let error):
                print(error)
            }})
    }
}
