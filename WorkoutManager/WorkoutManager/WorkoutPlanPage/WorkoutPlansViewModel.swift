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
    
    weak var delegate: ViewModelDelegate?
    var workoutPlan: WorkoutPlan?
    
    init(delegate:ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setWorkoutPlan(workoutPlan:WorkoutPlan) {
        self.workoutPlan = workoutPlan
    }
    
}
