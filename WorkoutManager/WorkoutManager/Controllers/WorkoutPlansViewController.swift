//
//  WorkoutPlansViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlansViewController: UIViewController {
    
    @IBOutlet private weak var workoutPlanInfo: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutPlanInfo.delegate = self
        workoutPlanInfo.dataSource = self
        workoutPlanInfo.register(WorkoutPlanItem.nib(), forCellWithReuseIdentifier: WorkoutPlanItem.identifier)
    }
}

extension WorkoutPlansViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkoutPlanItem.identifier, for: indexPath) as? WorkoutPlanItem else {
            return UICollectionViewCell()
        }
        return cell
    }
    
}
