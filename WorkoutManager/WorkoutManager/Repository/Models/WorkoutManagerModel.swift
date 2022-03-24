import Foundation
import UIKit

struct WorkoutManager: Codable, Hashable {
    
    enum Section: String, CaseIterable {
        case workoutPlans = "Workout Plans"
        case muscleExersises = "Muscle Excersises"
    }
    
    let workoutPlans: [WorkoutPlan]
    
    enum CodingKeys :String, CodingKey {
        case workoutPlans = "results"
    }
}

struct WorkoutPlan: Codable, Hashable {
    let id: Int
    let image: UIImage? 
    let name: String
    let description: String
}
