import UIKit

class WorkoutManagerViewController: UIViewController {

    private var workouts: WorkoutManager?
    
    @IBOutlet private weak var workoutPlans: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWorkoutPlans()
        
        workoutPlans.register(WorkoutsCollectionViewCell.nib(),
                              forCellWithReuseIdentifier: WorkoutsCollectionViewCell.indetifier)
        
        self.workoutPlans.delegate = self
        self.workoutPlans.dataSource = self
    }
    
    func getWorkoutPlans() {
        let url = Constants.baseURL?.appendingPathComponent("workout/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:WorkoutManager.self, completion: {[weak self]result in
        
            switch result {
                
            case .success(let workoutPlanData):
                self?.workouts = workoutPlanData
                DispatchQueue.main.async {
                    self?.workoutPlans.reloadData()
                }
            case .failure(let error):
                print(error)
            }})
    }

}

extension WorkoutManagerViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let finalWorkouts = self.workouts else {return 0}
        
        return finalWorkouts.workoutPlans.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = workoutPlans.dequeueReusableCell(withReuseIdentifier: WorkoutsCollectionViewCell.indetifier, for: indexPath) as! WorkoutsCollectionViewCell
        // swiftlint:enable force_cast
        guard let finalWorkouts = workouts else {
            return cell
        }
        
        cell.setCellAttributes(image: UIImage(named: "workout Image 2")!, status: "Active")
        
        return cell
    }
    
}

// extension WorkoutManagerViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        guard let finalWorkouts = workouts else {
//            cell.textLabel?.text = "No Workout Plans"
//            return cell
//        }
//
//        cell.textLabel?.text = finalWorkouts.workoutPlans[indexPath.row].name
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        guard let finalWorkouts = self.workouts else {
//            return 0
//        }
//         return finalWorkouts.workoutPlans.count
//    }
