//
//  WorkoutPlanItem.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlanItem: UICollectionViewCell {
    
    static var identifier = "WorkoutPlanItem"
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutPlanItem", bundle: nil)
    }

}
