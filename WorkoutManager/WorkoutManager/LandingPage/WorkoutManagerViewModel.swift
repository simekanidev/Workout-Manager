//
//  WorkoutManagerViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/24.
//

import Foundation

protocol WorkoutManagerDelegate : ViewModelDelegate {
    func reloadCollectionView()
}

class WorkoutManagerViewModel {
    
    private var workoutManagerData: WorkoutManager?
    private weak var delegate: WorkoutManagerDelegate?
    private var repository: WorkoutManagerRepositoryType?
    
    init (delegate: WorkoutManagerDelegate,
          repository: WorkoutManagerRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func workoutPlan(atIndex: Int) -> WorkoutPlan? {
        return workoutManagerData?.workoutPlans[atIndex] ?? nil
    }
    
    var workoutPlansCount: Int {
        return workoutManagerData?.workoutPlans.count ?? 0
    }
    
    func getworkoutPlansData() -> [WorkoutPlan]? {
        return workoutManagerData?.workoutPlans
    }
    
    func getWorkoutPlansFromApi() {
        repository?.fetchWorkoutPlans(completion: { [weak self] result in
            switch result {
            case .success(let workoutManagerData):
                self?.workoutManagerData = workoutManagerData
                self?.delegate?.reloadCollectionView()
            case .failure(let error):
                self?.delegate?.showError(error:error.rawValue)
            }})
    }
    
    func openWorkoutPlan(workoutPlanIndex: Int) {
        self.delegate?.navigateToPage(itemIndex: workoutPlanIndex)
    }
}
