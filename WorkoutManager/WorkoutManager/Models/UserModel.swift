//
//  UserModel.swift
//  RestApiHelpers
//
//  Created by Lloyd Hendricks on 2022/02/09.
//

import Foundation

// MARK: - User
struct User: Codable {

    let results : [UserDetails]?
    struct UserDetails: Codable {
            let age: Int?
            let gender: String?
            let height : Int?
            let calories: Int?
            let weightUnit: String?
        }
    }
    
