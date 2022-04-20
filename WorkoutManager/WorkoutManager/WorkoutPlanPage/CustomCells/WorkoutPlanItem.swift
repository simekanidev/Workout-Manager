//
//  WorkoutPlanItem.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/03/28.
//

import UIKit

class WorkoutPlanItem: UICollectionViewCell {

    @IBOutlet private var workoutsTableView:UITableView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var numberOfExersices: UILabel!
    private var workoutDay: DayModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    static var identifier = "WorkoutPlanItem"
    
    static func nib() -> UINib {
        return UINib(nibName: "WorkoutPlanItem", bundle: nil)
    }
    
    public func setData(day: DayModel) {
        self.workoutDay = day
        numberOfExersices.text = String(day.exercises?.count ?? 0)
        title.text = day.details?.description ?? "Day"
    }
}

extension WorkoutPlanItem: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutDay?.exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutInfoTableViewCell.identifier, for: indexPath) as?  WorkoutInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .secondaryColour
        
        guard let exercise = workoutDay?.exercises?[indexPath.item] else { return cell }
        cell.setData(exercise: exercise)
        return cell
    }
    
    private func configureTableView() {
        workoutsTableView.register(WorkoutInfoTableViewCell.nib(), forCellReuseIdentifier: WorkoutInfoTableViewCell.identifier)
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.backgroundColor = .secondaryColour
    }
}
