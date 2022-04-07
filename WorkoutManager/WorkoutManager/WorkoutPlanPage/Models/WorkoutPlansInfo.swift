//
//  WorkoutPlansInfo.swift
//  WorkoutManager
//
//  Created by Simekani Mabambi on 2022/04/07.
//

import Foundation

struct WorkoutPlanDetails: Codable {

    var details: Details?
    var days:[Day]?
    
    enum CodingKeys:String, CodingKey {
        case details = "obj"
        case days = "day_list"
    }
}

struct Details: Codable {
    var id: Int?
    var name: String?
    var description: String?
}

struct Day: Codable {
    var details: DayDetails?
    var exercises: [Exercise]?

    enum CodingKeys:String, CodingKey {
        case details = "obj"
        case exercises  = "set_list"
    }
}

struct DayDetails: Codable {
    var day: [Int?]?
    var description: String?
}

struct Exercise: Codable {
    var data: [ExerciseData]?

    enum CodingKeys:String, CodingKey {
        case data = "exercise_list"
    }
}

struct ExerciseData: Codable {
    var exerciseDetails: ExerciseDetails?
    var images: [ImageData]?
    enum CodingKeys:String, CodingKey {
        case exerciseDetails = "obj"
        case images = "image_list"
    }
}

struct ExerciseDetails:Codable {
    var name:String?
    var description: String?
    var language: Int?
}

struct ImageData: Codable {
    let path: String?
    let isThumbNail: Bool?
    enum CodingKeys:String, CodingKey {
        case isThumbNail = "is_main"
        case path = "image"
    }
}
