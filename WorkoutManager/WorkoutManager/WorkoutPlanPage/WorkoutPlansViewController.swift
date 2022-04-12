//
//  WorkoutPlansViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlansViewController: UIViewController {
    
    @IBOutlet private weak var workoutPlanInfo: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionText: UILabel!
    
    static var indentifier = "WorkoutPlansViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        populateData()
        viewModel.getWorkoutPlanDetails()
    }
    
    private lazy var viewModel = WorkoutPlansViewModel(delegate: self, repository: WorkoutPlansRepository())
    private var currentPage = 0
}

extension WorkoutPlansViewController {
    fileprivate func configureCollectionView() {
        workoutPlanInfo.delegate = self
        workoutPlanInfo.dataSource = self
        workoutPlanInfo.register(WorkoutPlanItem.nib(), forCellWithReuseIdentifier: WorkoutPlanItem.identifier)
        workoutPlanInfo.backgroundColor = .secondaryColour
        workoutPlanInfo.layer.cornerRadius = CGFloat(15)
    }
    
    private func populateData() {
        descriptionText.text = viewModel.getWorkoutPlan()?.description
    }
}

extension WorkoutPlansViewController: WorkoutPlansDelegate {
    func showError(error: String) {
        // will add code
    }
    
    func navigateToPage(itemIndex: Int?) {
        // will add code
    }
    
    func setWorkoutPlan(workoutPlan: WorkoutPlan) {
        viewModel.setWorkoutPlan(workoutPlan: workoutPlan)
    }
    
    func reloadCollectionView() {
        self.workoutPlanInfo.reloadData()
        
    }
}

extension WorkoutPlansViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDays
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkoutPlanItem.identifier, for: indexPath) as? WorkoutPlanItem else {
            return UICollectionViewCell()
        }
        guard let workoutDay = viewModel.getWorkoutInfo(itemIndex: indexPath.item) else {
            return cell
        }
        cell.setData(day: workoutDay)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 370, height: 640)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl.currentPage = currentPage
    }
}
