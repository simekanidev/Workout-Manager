//
//  CollectionViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

class WorkoutPlanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    static let identifier = "WorkoutPlanCollectionViewCell"
    
    func setCellProperties(workoutplan: WorkoutPlan) {
        imageView.image = (workoutplan.image != nil) ? workoutplan.image : UIImage(named: "workout1")
        statusLabel.text = workoutplan.name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutPlanCollectionViewCell", bundle: nil)
    }

}

extension WorkoutPlanCollectionViewCell {
    func styleCell () {
        self.imageView.layer.cornerRadius = 20
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 7
        self.imageView.layer.borderColor = UIColor.primaryColour
        imageView.contentMode = .scaleAspectFill
    }
}
