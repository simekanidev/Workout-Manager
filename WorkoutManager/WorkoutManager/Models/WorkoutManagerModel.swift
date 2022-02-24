//
//  WorkoutManagerModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/02/24.
//

import Foundation

struct WorkoutManager: Codable {
    let workoutPlans: [WorkoutPlan]
    
    enum CodingKeys :String, CodingKey {
        case workoutPlans = "results"
    }
}

struct WorkoutPlan: Codable {
    let id: Int
    let name: String
    let description: String
}
