//
//  CollectionViewExtension.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/14.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func styleWorkoutPlanCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 230, height: 370)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat(45)
        self.collectionViewLayout = layout
    }
    
}
