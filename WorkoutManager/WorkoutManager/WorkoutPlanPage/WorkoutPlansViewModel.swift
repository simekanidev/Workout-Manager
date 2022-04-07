//
//  WorkoutPlansViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/04/05.
//

import Foundation

protocol WorkoutPlansDelegate : ViewModelDelegate {
    
}

class WorkoutPlansViewModel {
    
    private weak var delegate: ViewModelDelegate?
    private var repository: WorkoutPlansRepositoryType?
    
    var workoutPlan: WorkoutPlan?
    var workoutPlanInfo: WorkoutPlanDetails?
    
    init(delegate:ViewModelDelegate, repository: WorkoutPlansRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func setWorkoutPlan(workoutPlan:WorkoutPlan) {
        self.workoutPlan = workoutPlan
    }
    
    func getWorkoutPlanDetails() {
        
        guard let id = workoutPlan?.id else {return}
        
        repository?.getWorkoutPlanById(id: id,completion: { [weak self] result in
            switch result {
            case .success(let workoutPlanDetails):
                self?.workoutPlanInfo = workoutPlanDetails
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
            
        })
    }
}
