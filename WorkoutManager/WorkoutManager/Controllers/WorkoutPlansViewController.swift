//
//  WorkoutPlansViewController.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlansViewController: UIViewController {
    
    @IBOutlet private weak var workoutPlanInfo: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutPlanInfo.delegate = self
        workoutPlanInfo.dataSource = self
        workoutPlanInfo.register(WorkoutPlanItem.nib(), forCellWithReuseIdentifier: WorkoutPlanItem.identifier)
        workoutPlanInfo.backgroundColor = UIColor(named: "ContrastBackground")
        workoutPlanInfo.layer.cornerRadius = CGFloat(15)
    }
    
    private var currentPage = 0
}

extension WorkoutPlansViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 370, height: 640)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        pageControl.currentPage = currentPage
    }
}
