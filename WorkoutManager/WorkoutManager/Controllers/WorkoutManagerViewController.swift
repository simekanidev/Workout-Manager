//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

typealias WorkoutManagerDataSource = UICollectionViewDiffableDataSource<WorkoutManager.Section, WorkoutPlan>
typealias WorkoutManagerSnapShot = NSDiffableDataSourceSnapshot<WorkoutManager.Section,WorkoutPlan>

class WorkoutManagerViewController: UIViewController {
    
    @IBOutlet private var workoutPlansCollectionView : UICollectionView!
    
    static let identifier = "WorkoutManagerViewController"
    
    private var workoutsDataSource: WorkoutManagerDataSource!
    private var workoutSnapshot: WorkoutManagerSnapShot!
    
    private lazy var viewModel = WorkoutManagerViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureCollectionView()
        configureWorkoutPlansDataSource()
        viewModel.getWorkoutPlans()
        
    }
    
}



extension WorkoutManagerViewController : WorkoutManagerDelegate{
    func reloadTableVIew() {
        self.workoutPlansCollectionView.reloadData()
    }
    
    func applyScreenshot(workoutManager: WorkoutManager) {
        self.applySnapShot(workoutPlans: workoutManager.workoutPlans)
    }
    
    func showError(error: String) {
        //will implement for upcoming feature
    }
    
    func navigateToPage() {
        //will implement for upcoming feature
    }
    
    
}


extension WorkoutManagerViewController {
    
    fileprivate func configureCollectionView() {
        workoutPlansCollectionView.register(WorkoutPlanCollectionViewCell.nib(),
                                            forCellWithReuseIdentifier: WorkoutPlanCollectionViewCell.identifier)
        
        workoutPlansCollectionView.collectionViewLayout = configureLandingPageCollectionView()
    }
    
    func configureLandingPageCollectionView() -> UICollectionViewCompositionalLayout {

        let sectionProvider = { ( sectionIndex: Int, _: NSCollectionLayoutEnvironment ) -> NSCollectionLayoutSection? in
            // Other Sections will be added here
            return self.workoutPlansSection()
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)

    }
    
    func workoutPlansSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(270),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top:10, leading:15, bottom: 10 , trailing: 15)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3/2),
                                              heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading:10, bottom: 10, trailing: 10)

        return section
    }
    
    func configureWorkoutPlansDataSource() {
        self.workoutsDataSource = WorkoutManagerDataSource(collectionView: self.workoutPlansCollectionView) { (collectionView:UICollectionView, indexPath:IndexPath, _:WorkoutPlan) -> UICollectionViewCell? in
            
            let reuseIdentifier: String
            
            switch indexPath.section {
            case 0: reuseIdentifier = WorkoutPlanCollectionViewCell.identifier
            case 1: reuseIdentifier = MusleWorkoutsCollectionViewCell.identifier
            default: reuseIdentifier = MusleWorkoutsCollectionViewCell.identifier
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WorkoutPlanCollectionViewCell else { return nil }
            
            guard let finalWorkouts = self.viewModel.workoutManager?.workoutPlans else {return cell}
            
            cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
            cell.styleCell()
            return cell
        }
        
    }
    
    func applySnapShot(workoutPlans: [WorkoutPlan]) {
        self.workoutSnapshot = WorkoutManagerSnapShot()
        self.workoutSnapshot.appendSections([WorkoutManager.Section.workoutPlans])
        self.workoutSnapshot.appendItems(workoutPlans)
        self.workoutsDataSource.apply(self.workoutSnapshot,animatingDifferences: false)
        
    }
}
