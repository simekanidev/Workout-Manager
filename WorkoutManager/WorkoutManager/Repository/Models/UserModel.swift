import Foundation

struct UserModel: Codable {

    let results : [UserDetails]?
    struct UserDetails: Codable {
            let age: Int?
            let gender: String?
            let height : Int?
            let calories: Int?
            let weightUnit: String?
        }
    }
    
