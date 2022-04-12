//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

class WorkoutManagerViewController:UIViewController {
    
    @IBOutlet private var workoutPlansCollectionView : UICollectionView!
    
    static let identifier = "WorkoutManagerViewController"
    
    private lazy var viewModel = WorkoutManagerViewModel(delegate: self,repository: WorkoutManagerRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.getWorkoutPlansFromApi()
    }
}

// MARK: Workout Manager Delegate
extension WorkoutManagerViewController : WorkoutManagerDelegate {
    func reloadCollectionView() {
        self.workoutPlansCollectionView.reloadData()
        
    }

    func showError(error: String) {
        // will implement for upcoming feature
    }
    
    func navigateToPage(itemIndex:Int?) {
        let workoutPlanIndex:Int
        workoutPlanIndex = (itemIndex != nil) ? itemIndex! : 0
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: WorkoutPlansViewController.indentifier) as?
            WorkoutPlansViewController {
            viewController.navigationItem.title = self.viewModel.workoutPlan(atIndex: workoutPlanIndex)?.name
            viewController.setWorkoutPlan(workoutPlan: (self.viewModel.workoutPlan(atIndex: workoutPlanIndex)!))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openWorkoutPlan(workoutPlanIndex: indexPath.item)
    }
    
    fileprivate func configureCollectionView() {
        
        workoutPlansCollectionView.register(WorkoutPlanCollectionViewCell.nib(),
                                            forCellWithReuseIdentifier: WorkoutPlanCollectionViewCell.identifier)
        workoutPlansCollectionView.dataSource = self
        workoutPlansCollectionView.delegate = self
        
        workoutPlansCollectionView.collectionViewLayout = configureCollectionViewLayout()
    }
}

extension WorkoutManagerViewController: UICollectionViewDelegateFlowLayout {
    private func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
          let layout = UICollectionViewFlowLayout()
          layout.itemSize = CGSize(width: 230, height: 370)
          layout.scrollDirection = .horizontal
          layout.minimumLineSpacing = CGFloat(40)
          return layout
      }
}
