import UIKit

class UserViewController: UIViewController {
    
    private var userUser: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserDetails()
    }
    
    func getUserDetails() {
        let url = Constants.baseURL?.appendingPathComponent("userprofile/")
        URLSession.shared.makeRequest(url: url,method: .get, returnModel:UserModel.self, completion: {[weak self]result in

            switch result {
            case .success(let userArray):
                print(userArray)
            case .failure(let error):
                print(error)
            }})
    }
}
