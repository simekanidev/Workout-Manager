//
//  WorkoutPlanItem.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlanItem: UICollectionViewCell {

    @IBOutlet private var workoutsTableView:UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        workoutsTableView.register(WorkoutInfoTableViewCell.nib(), forCellReuseIdentifier: WorkoutInfoTableViewCell.identifier)
        
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
    }
    
    static var identifier = "WorkoutPlanItem"
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutPlanItem", bundle: nil)
    }

}

extension WorkoutPlanItem: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutInfoTableViewCell.identifier, for: indexPath) as?  WorkoutInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
