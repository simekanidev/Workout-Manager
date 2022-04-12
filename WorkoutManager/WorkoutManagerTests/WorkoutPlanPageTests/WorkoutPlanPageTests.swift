//
//  WorkoutPlanPageTests.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/12.
//

import XCTest

@testable import WorkoutManager
class WorkoutPlanPageTests: XCTestCase {
    
    var viewModel: WorkoutManagerViewModel!
    var mockrepository: MockWorkoutPlanRepository!
    
    class MockWorkoutPlanRepository:WorkoutPlansRepositoryType {
        func getWorkoutPlanById(id: Int, completion: @escaping (WorkoutPlanResult)) {
            completion(.success(mockWorkoutPlanDetails))
        }
        
        let mockWorkoutPlanDetails = WorkoutPlanDetails(details:
                                                            Details(id: 1,
                                                                    name: "5 week program ",
                                                                    description: "5 week program helps to make core strong"),
                                                                    days: [Day(details:
                                                                    DayDetails(day: [1],
                                                                               description: "Leg Day"),
                                                                   exercises: [Exercise(data:
                                                                                            [ExerciseData(exerciseDetails:
                                                                                                            ExerciseDetails(
                                                                                                                name: "Leg Press",
                                                                                                                description: "Push legs up and down ",
                                                                                                                language: 1, sets: 5), images: [ImageData(path: "/image-1", isThumbNail: false)], repsData: [RepetitionsData(repetitionUnit: 1, repetitions: 15)])], setData: SetData(sets: 1))])])
        
    }
    
    class MockWorkoutPlanRepositoryFailed:WorkoutPlansRepositoryType {
        func getWorkoutPlanById(id: Int, completion: @escaping (WorkoutPlanResult)) {
            completion(.failure(.invalidData))
        }
    }
}
