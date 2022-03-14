import Foundation

struct WorkoutManager: Codable, Hashable {
    let workoutPlans: [WorkoutPlan]
    
    enum CodingKeys :String, CodingKey {
        case workoutPlans = "results"
    }
}

struct WorkoutPlan: Codable, Hashable {
    let id: Int
    let name: String
    let description: String
}
