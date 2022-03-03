//
//  WorkoutManagerViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/02/24.
//

import UIKit

class WorkoutManagerViewController: UIViewController {

    private var workouts: WorkoutManager?
    
    @IBOutlet var tableview:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getWorkoutPlans()
            
        self.tableview.delegate = self
        self.tableview.dataSource = self
       
    }
    
    func getWorkoutPlans() {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {[weak self] result in
            
            switch result {
                
            case .success(let workoutPlanData):
                self?.workouts = workoutPlanData
                DispatchQueue.main.async {
                    self?.tableview.reloadData()
                }
            case .failure(let error):
                print(error)
            }})
    }

}

extension WorkoutManagerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let finalWorkouts = workouts else {
            cell.textLabel?.text = "No Workout Plans"
            return cell
        }
        
        cell.textLabel?.text = finalWorkouts.workoutPlans[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let finalWorkouts = self.workouts else { return 0 }
        
         return finalWorkouts.workoutPlans.count
    }
}
