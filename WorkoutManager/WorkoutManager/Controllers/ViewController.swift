//
//  ViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

class ViewController: UIViewController {
    
    private var workouts: WorkoutManager?
    
    @IBOutlet var workoutPlans : UICollectionView!

    private func configureCollectionView() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 230, height: 370)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutPlans.register(CollectionViewCell.nib(),
                              forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        workoutPlans.collectionViewLayout = self.configureCollectionView()
        workoutPlans.delegate = self
        workoutPlans.dataSource = self
        
        getWorkoutPlans()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        guard let finalWorkouts = self.workouts?.workoutPlans  else {return cell}
        
        cell.setCellProperties(image: UIImage(named: "workout1")!, label: (finalWorkouts[indexPath.row].name))
        // swiftlint:enable force_cast
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 370)
    }
}

extension ViewController {
    
    func getWorkoutPlans() {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {[weak self]result in
        
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
