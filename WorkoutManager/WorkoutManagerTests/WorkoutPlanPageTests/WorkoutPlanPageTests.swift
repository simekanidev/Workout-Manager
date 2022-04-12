//
//  WorkoutPlanPageTests.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/12.
//

import XCTest

@testable import WorkoutManager
class WorkoutPlanPageTests: XCTestCase {
    
    var viewModel: WorkoutPlansViewModel!
    var mockrepository: MockWorkoutPlanRepository!
    var mockdelegat: MockWorkoutPlanDelegate!
    
    override func setUp() {
        super.setUp()
        mockdelegat = MockWorkoutPlanDelegate()
        mockrepository = MockWorkoutPlanRepository()
        viewModel = WorkoutPlansViewModel(delegate: mockdelegat, repository: mockrepository)
    }
    
    
    
    
    class MockWorkoutPlanDelegate: WorkoutPlansDelegate{
        
        var reloadCalled  = false
        var showErrorCalled = false
        var navigateToPageCalled = false
        
        func reloadCollectionView() {
            reloadCalled = true
        }
        
        func showError(error: String) {
            showErrorCalled = true
        }
        
        func navigateToPage(itemIndex: Int?) {
            navigateToPageCalled = true
        }
    }
    
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
                                                                                            [ExerciseData(exerciseDetails:ExerciseDetails(
                                                                                                name: "Leg",
                                                                                                description: "Pus",
                                                                                                language: 1, sets: 5),
                                                                                                          images: [ImageData(path: "/image-1", isThumbNail: false)],
                                                                                                          repsData: [RepetitionsData(repetitionUnit:1, repetitions: 15)])],
                                                                                        setData: SetData(sets: 1))])])
        
    }
    
    class MockWorkoutPlanRepositoryFailed:WorkoutPlansRepositoryType {
        func getWorkoutPlanById(id: Int, completion: @escaping (WorkoutPlanResult)) {
            completion(.failure(.invalidData))
        }
    }
}
