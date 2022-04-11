//
//  WorkoutInfoTableViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/29.
//

import UIKit

class WorkoutInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutImage: UIImageView!
    @IBOutlet weak var exersiceName: UILabel!
    @IBOutlet weak var numberOfReps: UILabel!
    @IBOutlet weak var numberOfSets: UILabel!
    private var exersise:Exercise?
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
    
    public func setData(exercise: Exercise) {
        self.exersise = exercise
        self.exersiceName.text = exercise.data?[0].exerciseDetails?.name
        self.numberOfReps.text = String(exercise.data?[0].repsData?[0].repetitions ?? 10)
        self.numberOfSets.text = String(exercise.setData?.sets ?? 0)
    }
}
