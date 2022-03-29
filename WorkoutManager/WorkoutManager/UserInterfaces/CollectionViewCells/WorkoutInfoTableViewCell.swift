//
//  WorkoutInfoTableViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/29.
//

import UIKit

class WorkoutInfoTableViewCell: UITableViewCell {

    static var identifier = "WorkoutInfoTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
