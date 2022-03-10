//
//  WorkoutsCollectionViewCell.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/08.
//

import UIKit

class WorkoutsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let indetifier = "WorkoutsCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCellAttributes(image: UIImage, status: String) {
        self.imageView.image = image
        self.imageView.layer.cornerRadius = 10
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 20
        self.imageView.layer.borderColor = UIColor(named: "Primary Colour")?.cgColor
        self.statusLabel.text = status
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutsCollectionViewCell", bundle: nil)
    }
}
