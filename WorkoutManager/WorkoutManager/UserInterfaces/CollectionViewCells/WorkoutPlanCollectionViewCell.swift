//
//  CollectionViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/09.
//

import UIKit

class WorkoutPlanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    static let identifier = "WorkoutPlanCollectionViewCell"
    
    
    func setCellProperties(image: UIImage, label: String) {
        imageView.image = image
        self.imageView.layer.cornerRadius = 20
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 7
        self.imageView.layer.borderColor = UIColor.primaryColour
        imageView.contentMode = .scaleAspectFill
        statusLabel.text = label
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutPlanCollectionViewCell", bundle: nil)
    }

}
