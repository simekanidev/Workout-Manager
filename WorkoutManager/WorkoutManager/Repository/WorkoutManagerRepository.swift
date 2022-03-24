//
//  WorkoutManagerRepository.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/24.
//

import Foundation

typealias WorkoutPlansResult = (Result<WorkoutManager, Error>) -> Void

protocol WorkoutManagerRepositoryType:AnyObject {
    func fetchWorkoutPlans(completion: @escaping(WorkoutPlansResult))
}

class WorkoutManagerRepository: WorkoutManagerRepositoryType {
    
    func fetchWorkoutPlans(completion: @escaping(WorkoutPlansResult)) {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: completion)
    }

}
