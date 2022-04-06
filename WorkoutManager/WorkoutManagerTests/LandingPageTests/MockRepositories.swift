//
//  MockRepositories.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/06.
//

import Foundation
@testable import WorkoutManager

public class MockWorkoutManagerRepository:WorkoutManagerRepositoryType {
    
   public let mockWorkoutManager = WorkoutManager(workoutPlans:
                                                [WorkoutPlan(id: 1, name: "", description: ""),
                                                 WorkoutPlan(id: 2, name: "", description: ""),
                                                 WorkoutPlan(id: 3, name: "", description: "")])
    
    public func fetchWorkoutPlans(completion: @escaping (WorkoutPlansResult)) {
        let workoutManager: WorkoutManager = mockWorkoutManager
        completion(.success(workoutManager))
    }
}

public class MockWorkoutManagerRepositoryFail:WorkoutManagerRepositoryType {
   public func fetchWorkoutPlans(completion: @escaping (WorkoutPlansResult)) {
        completion(.failure(.invalidData))
    }
}
