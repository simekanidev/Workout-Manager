//
//  WorkoutManagerViewModel.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/24.
//

import Foundation

protocol WorkoutManagerDelegate : ViewModelDelegate{
    func reloadTableVIew()
    func applyScreenshot(workoutManager:WorkoutManager)
}

class WorkoutManagerViewModel{
    
     var workoutManager: WorkoutManager?
    
     var delegate: WorkoutManagerDelegate
    
    init (delegate: WorkoutManagerDelegate){
        self.delegate = delegate
    }

    
    func getWorkoutPlans() {
        
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {
            [weak self] result in
            
            switch result {
            case .success(let workoutPlanData):
                self?.workoutManager = workoutPlanData
                DispatchQueue.main.async {
                    guard let workoutPlans = self?.workoutManager?.workoutPlans else { return }
                    let workoutManger = WorkoutManager(workoutPlans: workoutPlans)
                    self?.delegate.applyScreenshot(workoutManager: workoutManger)
                    self?.delegate.reloadTableVIew()
                }
            case .failure(let error):
                print(error)
            }})
    }

    
}
