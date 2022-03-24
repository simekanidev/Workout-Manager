//
//  WorkoutManagerViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/24.
//

import Foundation

protocol WorkoutManagerDelegate : ViewModelDelegate {
    func reloadCollectionView()
    func applyScreenshot(workoutManager:WorkoutManager)
}

class WorkoutManagerViewModel {
    
    var workoutManager: WorkoutManager?
    weak var delegate: WorkoutManagerDelegate?
    var repository: WorkoutManagerRepositoryType?
    
    init (delegate: WorkoutManagerDelegate, repository: WorkoutManagerRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func workoutPlan(atIndex: Int) -> WorkoutPlan? {
        return workoutManager?.workoutPlans[atIndex] ?? nil
    }
    
    func getWorkoutPlans() {
        repository?.fetchWorkoutPlans(completion: {[weak self] result in
            switch result {
            case .success(let workoutManagerData):
                self?.workoutManager = workoutManagerData
                    guard let workoutPlans = self?.workoutManager?.workoutPlans else { return }
                    let workoutManger = WorkoutManager(workoutPlans: workoutPlans)
                    self?.delegate?.applyScreenshot(workoutManager: workoutManger)
                    self?.delegate?.reloadCollectionView()
            case .failure(let error):
                print(error)
            }})
    }
    
}
