//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

enum Section {
    case workoutPlans
}

typealias WorkoutManagerDataSource = UICollectionViewDiffableDataSource<Section, WorkoutPlan>
typealias WorkoutManagerSnapShot = NSDiffableDataSourceSnapshot<Section,WorkoutPlan>

class WorkoutManagerViewController: UIViewController {
    
    private var workoutsDataSource:WorkoutManagerDataSource!
    private var workoutSnapshot:WorkoutManagerSnapShot!
    
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
        
        workoutPlans.collectionViewLayout = configureCollectionView()
        // workoutPlans.delegate = self
        // workoutPlans.dataSource = self
        configureWorkoutPlansDataSource()
        
        getWorkoutPlans()
        
    }
    
}

extension WorkoutManagerViewController {
    
//    func configureLandingPageCollectionView() -> UICollectionViewCompositionalLayout {
//
//        let sectionProvider = { ( sectionIndex: Int, _: NSCollectionLayoutEnvironment ) -> NSCollectionLayoutSection? in
//            var section : NSCollectionLayoutSection
//
//            switch sectionIndex {
//            case 0 :
//                section = self.workoutPlansSection()
//
//            case 1:
//                section = self.workoutPlansSection()
//            default:
//                section = self.workoutPlansSection()
//            }
//
//            return section
//        }
//
//        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
//
//    }
    
    func workoutPlansSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(230),
                                              heightDimension: .absolute(370))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
}

// MARK: Data Source

extension WorkoutManagerViewController {
    
    func configureWorkoutPlansDataSource() {
        
        workoutsDataSource = WorkoutManagerDataSource(collectionView: workoutPlans) { (collectionView:UICollectionView, indexPath:IndexPath, _:WorkoutPlan) -> UICollectionViewCell? in
         
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutPlanCollectionViewCell.identifier, for: indexPath) as? WorkoutPlanCollectionViewCell else {return nil }
    
            guard let finalWorkouts = self.workouts?.workoutPlans  else {return cell}
    
            cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
          
            return cell
           
        }
          
      }
    
    func applySnapShot(workoutPlans: [WorkoutPlan]) {
        workoutSnapshot = WorkoutManagerSnapShot()
        workoutSnapshot.appendSections([Section.workoutPlans])
        workoutSnapshot.appendItems(workoutPlans)
        workoutsDataSource.apply(workoutSnapshot,animatingDifferences: false)
        
    }
    
}

//
// extension WorkoutManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // swiftlint:disable force_cast
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutPlanCollectionViewCell.identifier, for: indexPath) as! WorkoutPlanCollectionViewCell
//
//        guard let finalWorkouts = self.workouts?.workoutPlans  else {return cell}
//
//        cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
//        // swiftlint:enable force_cast
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//
//        print("You selescted an item")
//    }
//
//    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
//        guard let finalWorkouts = self.workouts else {return 0}
//        return finalWorkouts.workoutPlans.count
//    }
// }

// extension WorkoutManagerViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 230, height: 370)
//    }
// }

extension WorkoutManagerViewController {
    
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
