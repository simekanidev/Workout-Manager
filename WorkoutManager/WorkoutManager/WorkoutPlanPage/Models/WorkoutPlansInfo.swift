//
//  WorkoutPlansInfo.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/04/07.
//

import Foundation

struct WorkoutPlanDetails: Codable {

    var details: Details?
    var days:[Day]?
    
    enum CodingKeys:String, CodingKey {
        case details = "obj"
    }
}

struct Details: Codable {
    var id: Int?
    var name: String?
    var description: String?
}

struct Day:Codable {
    
}
