//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

typealias WorkoutManagerDataSource = UICollectionViewDiffableDataSource<WorkoutManager.Section, WorkoutPlan>
typealias WorkoutManagerSnapShot = NSDiffableDataSourceSnapshot<WorkoutManager.Section,WorkoutPlan>

class WorkoutManagerViewController:UIViewController, WorkoutManagerDelegate {
    
    @IBOutlet private var workoutPlansCollectionView : UICollectionView!
    
    static let identifier = "WorkoutManagerViewController"
    
    private lazy var viewModel = WorkoutManagerViewModel(delegate: self,repository: WorkoutManagerRepository())
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutPlansCollectionView.delegate = self
        configureCollectionView()
        viewModel.getWorkoutPlans()
    }
}

// MARK: Workout Manager Delegate
extension WorkoutManagerViewController {
    func reloadCollectionView() {
        self.workoutPlansCollectionView.reloadData()
    }

    func showError(error: String) {
        // will implement for upcoming feature
    }
    
    func navigateToPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: WorkoutPlansViewController.indentifier) as?
            WorkoutPlansViewController {
            viewController.navigationItem.title = "Workout A"
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}

// MARK: Collection view configuration

extension WorkoutManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.workoutPlansCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutPlanCollectionViewCell.identifier, for: indexPath) as? WorkoutPlanCollectionViewCell else { return UICollectionViewCell() }
        
        guard let workoutPlan = self.viewModel.workoutPlan(atIndex: indexPath.item) else { return UICollectionViewCell()}
        
        cell.setCellProperties(workoutplan: workoutPlan)
        cell.styleCell()
        return cell
    }
    
    fileprivate func configureCollectionView() {
        
        workoutPlansCollectionView.register(WorkoutPlanCollectionViewCell.nib(),
                                            forCellWithReuseIdentifier: WorkoutPlanCollectionViewCell.identifier)
        workoutPlansCollectionView.dataSource = self
        workoutPlansCollectionView.delegate = self
    }
        
}
