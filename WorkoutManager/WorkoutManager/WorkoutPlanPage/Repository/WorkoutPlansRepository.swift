//
//  WorkoutPlansRepository.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/04/07.
//

import Foundation

typealias WorkoutPlanResult = (Result<WorkoutPlanDetailsModel, URLSession.CustomError>) -> Void
protocol WorkoutPlansRepositoryType : AnyObject {
    func getWorkoutPlanById(id: Int, completion: @escaping(WorkoutPlanResult))
}

class WorkoutPlansRepository: WorkoutPlansRepositoryType {
    func getWorkoutPlanById(id: Int, completion: @escaping(WorkoutPlanResult)) {
        let url = Constants.baseURL?
            .appendingPathComponent("workout/")
            .appendingPathComponent(String(id))
            .appendingPathComponent("/canonical_representation/")
        URLSession.shared.makeRequest(url: url,method: .get,returnModel: WorkoutPlanDetailsModel.self, completion: completion)
    }
}
