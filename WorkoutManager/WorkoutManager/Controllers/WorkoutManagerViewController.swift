//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

class WorkoutManagerViewController: UIViewController {
    
    private var workouts: WorkoutManager?
    
    @IBOutlet var workoutPlans : UICollectionView!

    private func configureCollectionView() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 230, height: 370)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat(45)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutPlans.register(WorkoutPlanCollectionViewCell.nib(),
                              forCellWithReuseIdentifier: WorkoutPlanCollectionViewCell.identifier)
        
        workoutPlans.styleWorkoutPlanCollectionView()
        workoutPlans.delegate = self
        workoutPlans.dataSource = self
        getWorkoutPlans()

    }
}

extension WorkoutManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutPlanCollectionViewCell.identifier, for: indexPath)
                as? WorkoutPlanCollectionViewCell else { return UICollectionViewCell()}
        
        guard let finalWorkouts = self.workouts?.workoutPlans  else {return cell}
        
        cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You selescted an item")
    }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        guard let finalWorkouts = self.workouts else {return 0}
        return finalWorkouts.workoutPlans.count
    }
}

extension WorkoutManagerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 370)
    }
}

extension WorkoutManagerViewController {
    
    func getWorkoutPlans() {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {
            [weak self] result in
        
            switch result {
                
            case .success(let workoutPlanData):
                self?.workouts = workoutPlanData
                DispatchQueue.main.async {
                    self?.workoutPlans.reloadData()
                }
            case .failure(let error):
                print(error)
            }})
    }
    
}
