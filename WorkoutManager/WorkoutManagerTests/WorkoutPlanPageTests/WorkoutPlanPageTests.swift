//
//  WorkoutPlanPageTests.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/12.
//

import XCTest

@testable import WorkoutManager
class WorkoutPlanPageTests: XCTestCase {
    
    private var viewModel: WorkoutPlansViewModel!
    private var mockrepository: MockWorkoutPlanRepository!
    private var mockdelegat: MockWorkoutPlanDelegate!
    
    override func setUp() {
        super.setUp()
        mockdelegat = MockWorkoutPlanDelegate()
        mockrepository = MockWorkoutPlanRepository()
        viewModel = WorkoutPlansViewModel(delegate: mockdelegat, repository: mockrepository)
    }
    
    func testSetWorkoutPlanPass() {
        viewModel.setWorkoutPlan(workoutPlan: WorkoutPlan(id: 1, name: "", description: ""))
        XCTAssertNotNil(viewModel.getWorkoutPlan())
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(0, viewModel.numberOfDays)
    }
    
    func testNumberOfDaysSet() {
        viewModel.setWorkoutPlan(workoutPlan: WorkoutPlan(id: 1, name: "", description: ""))
        viewModel.getWorkoutPlanDetails()
        XCTAssertEqual(1, viewModel.numberOfDays)
    }
    
    func testSetWorkoutPlanNil() {
        // viewModel.setWorkoutPlan(nil)
        XCTAssertNil(viewModel.getWorkoutPlan())
    }
    
    func testGetWorkoutInfoReturnsNil() {
        viewModel.setWorkoutPlan(workoutPlan: WorkoutPlan(id: 1, name: "", description: ""))
        viewModel.getWorkoutPlanDetails()
        viewModel = WorkoutPlansViewModel(delegate: mockdelegat, repository: MockWorkoutPlanRepositoryFailed())
        XCTAssertNil(viewModel.getWorkoutInfo(itemIndex:0))
    }
    
    func testGetWorkoutInfoPassed() {
        viewModel.setWorkoutPlan(workoutPlan: WorkoutPlan(id: 1, name: "", description: ""))
        viewModel.getWorkoutPlanDetails()
        viewModel.getWorkoutPlanDetails()
        XCTAssertNotNil(viewModel.getWorkoutInfo(itemIndex:0))
    }
    
    func testGetworkoutPlanDetailsFailure() {
        viewModel = WorkoutPlansViewModel(delegate: mockdelegat, repository: MockWorkoutPlanRepositoryFailed())
        viewModel.setWorkoutPlan(workoutPlan: WorkoutPlan(id: 1, name: "", description: ""))
        viewModel.getWorkoutPlanDetails()
        XCTAssertTrue(self.mockdelegat.showErrorCalled)
    }
    
    func testGetworkoutPlanDetailsFailureWorkoutPlanIdNotSet() {
        viewModel.getWorkoutPlanDetails()
        XCTAssertFalse(self.mockdelegat.showErrorCalled)
        XCTAssertFalse(self.mockdelegat.reloadCalled)
    }
    
    class MockWorkoutPlanDelegate: WorkoutPlansDelegate {
        
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
        let mockWorkoutPlanDetails = WorkoutPlanDetails(details:Details(id: 1, name: "5 week program ",description: "5 week program helps to make core strong"), days:[Day(details:DayDetails(day: [1],
                                        description: "Leg Day"),
                                        exercises:[Exercise(data:[ExerciseData(exerciseDetails:ExerciseDetails(
                                                                        name: "Leg",description: "Pus",language: 1, sets: 5),
                                                                        images: [ImageData(path: "/image-1",isThumbNail: false)],
                                                                        repsData: [RepetitionsData(repetitionUnit:1,repetitions: 15)])],setData: SetData(sets: 1))])])
        
    }
    
    class MockWorkoutPlanRepositoryFailed:WorkoutPlansRepositoryType {
        func getWorkoutPlanById(id: Int, completion: @escaping (WorkoutPlanResult)) {
            completion(.failure(.invalidData))
        }
    }
}
