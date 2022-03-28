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
    
    private var workoutPlansInfo: WorkoutManager?
    private weak var delegate: WorkoutManagerDelegate?
    private var repository: WorkoutManagerRepositoryType?
    
    init (delegate: WorkoutManagerDelegate, repository: WorkoutManagerRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func workoutPlan(atIndex: Int) -> WorkoutPlan? {
        return workoutPlansInfo?.workoutPlans[atIndex] ?? nil
    }
    
    func getWorkoutPlans() {
        repository?.fetchWorkoutPlans(completion: { [weak self] result in
            switch result {
            case .success(let workoutManagerData):
                self?.workoutPlansInfo = workoutManagerData
                    guard let workoutPlans = self?.workoutPlansInfo?.workoutPlans else { return }
                    let workoutManger = WorkoutManager(workoutPlans: workoutPlans)
                    self?.delegate?.applyScreenshot(workoutManager: workoutManger)
                    self?.delegate?.reloadCollectionView()
            case .failure(let error):
                print(error)
            }})
    }
    
}
