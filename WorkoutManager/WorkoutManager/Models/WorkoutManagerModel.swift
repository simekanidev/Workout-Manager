
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
