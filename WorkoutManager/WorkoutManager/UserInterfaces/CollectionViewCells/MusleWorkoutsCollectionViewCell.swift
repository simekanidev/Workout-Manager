//
//  MusleWorkoutsCollectionViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/14.
//

import UIKit

class MusleWorkoutsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var muscleImage: UIImageView!
    @IBOutlet private weak var muscleName: UILabel!
    static let identifier = "MusleWorkoutsCollectionViewCell"
 
    func setCellProperties(image:UIImage, muscleName:String) {
        self.muscleImage.image = image
        self.muscleName.text = muscleName
        contentView.backgroundColor = .red
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MusleWorkoutsCollectionViewCell", bundle: nil)
    }

}
