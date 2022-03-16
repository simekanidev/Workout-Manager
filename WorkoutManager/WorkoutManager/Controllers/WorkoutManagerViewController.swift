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
    
    @IBOutlet private var workoutPlans : UICollectionView!
    
    private var workoutsDataSource: WorkoutManagerDataSource!
    private var workoutSnapshot: WorkoutManagerSnapShot!
    private var workouts: WorkoutManager?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        workoutPlans.register(WorkoutPlanCollectionViewCell.nib(),
                              forCellWithReuseIdentifier: WorkoutPlanCollectionViewCell.identifier)
        
        workoutPlans.register(MusleWorkoutsCollectionViewCell.nib(),
                              forCellWithReuseIdentifier: MusleWorkoutsCollectionViewCell.identifier)
        
        workoutPlans.collectionViewLayout = configureLandingPageCollectionView()
        configureWorkoutPlansDataSource()
        getWorkoutPlans()
        
    }
    
}

extension WorkoutManagerViewController {
    
    func configureLandingPageCollectionView() -> UICollectionViewCompositionalLayout {

        let sectionProvider = { ( sectionIndex: Int, _: NSCollectionLayoutEnvironment ) -> NSCollectionLayoutSection? in
            var section : NSCollectionLayoutSection

            switch sectionIndex {
            case 0 :
                section = self.workoutPlansSection()

            case 1:
                // TODO : Other section to be added
                section = self.workoutPlansSection()
            default:
                section = self.workoutPlansSection()
            }

            return section
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
        workoutsDataSource = WorkoutManagerDataSource(collectionView: workoutPlans) { (collectionView:UICollectionView, indexPath:IndexPath, _:WorkoutPlan) -> UICollectionViewCell? in
            
            let reuseIdentifier: String
            
            switch indexPath.section {
            case 0: reuseIdentifier = WorkoutPlanCollectionViewCell.identifier
            case 1: reuseIdentifier = MusleWorkoutsCollectionViewCell.identifier
            default: reuseIdentifier = MusleWorkoutsCollectionViewCell.identifier
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? WorkoutPlanCollectionViewCell else {return nil }
            
           
            
            guard let finalWorkouts = self.workouts?.workoutPlans  else {return cell}
            
            cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
            return cell
        }
        
    }
    
    func applySnapShot(workoutPlans: [WorkoutPlan]) {
        workoutSnapshot = WorkoutManagerSnapShot()
        workoutSnapshot.appendSections([WorkoutManager.Section.workoutPlans])
        workoutSnapshot.appendItems(workoutPlans)
        workoutsDataSource.apply(workoutSnapshot,animatingDifferences: false)
        
    }
    
    func getWorkoutPlans() {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {[weak self]result in
            switch result {
            case .success(let workoutPlanData):
                self?.workouts = workoutPlanData
                DispatchQueue.main.async {
                    
                    guard let workouts = self?.workouts?.workoutPlans else { return}
                    self?.applySnapShot(workoutPlans: workouts)
                    self?.workoutPlans.reloadData()
                }
            case .failure(let error):
                print(error)
            }})
    }
}
