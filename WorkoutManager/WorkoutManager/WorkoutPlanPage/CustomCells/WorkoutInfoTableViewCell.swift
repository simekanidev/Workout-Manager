//
//  WorkoutInfoTableViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/29.
//

import UIKit

class WorkoutInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutImage: UIImageView!
    
    static var identifier = "WorkoutInfoTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        workoutImage.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
}
