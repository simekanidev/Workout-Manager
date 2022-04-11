//
//  LandingPageTests.swift
//  WorkoutManagerTests
//
//  Created by Simekani Mabambi on 2022/04/06.
//

import XCTest
@testable import WorkoutManager

class LandingPageTests: XCTestCase {
    
    var viewModel: WorkoutManagerViewModel!
    var mockdelegat: MockWorkoutMangerDelegate!

    override func setUp() {
        super.setUp()
        
        mockdelegat = MockWorkoutMangerDelegate()
        viewModel = WorkoutManagerViewModel(delegate: mockdelegat,
                                            repository: MockWorkoutManagerRepository())
        
    }
    
    func failedToRetrieveWorkoutPlans() {
        viewModel =  WorkoutManagerViewModel(delegate: mockdelegat,
                                             repository: MockWorkoutManagerRepositoryFail())
        
        viewModel.getWorkoutPlansFromApi()
    }
    
    func testGetWorkoutPlansByIndexWhenGetWorkoutplansFromApiNotCalled() {
        XCTAssertNil(viewModel.workoutPlan(atIndex:1))
    }
    
    func testGetWorkoutPlansCountWhenGetWorkoutplansFromApiNotCalled() {
        XCTAssertEqual(viewModel.workoutPlansCount, 0)
    }
    
    func testGetworkoutPlanByIndex () {
        viewModel.getWorkoutPlansFromApi()
        XCTAssertEqual(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[1], viewModel.workoutPlan(atIndex: 1))
    }
    
    func testGetworkoutPlanByIndexFail () {
        viewModel.getWorkoutPlansFromApi()
        XCTAssertNotEqual(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[2], viewModel.workoutPlan(atIndex: 1))
    }
    
    func testGetworkoutPlanByIndexGetWorkoutPlansFailed () {
        failedToRetrieveWorkoutPlans()
        XCTAssertNotNil(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[2])
    }
    
     func testGetWorkoutPlansPass() {
         viewModel.getWorkoutPlansFromApi()
         XCTAssertNotNil(viewModel.getworkoutPlansData())
    }
    
    func testGetWorkoutPlansFail() {
        failedToRetrieveWorkoutPlans()
        viewModel.getWorkoutPlansFromApi()
        XCTAssertNil(viewModel.getworkoutPlansData())
   }
    
    func testOpenWorkoutPlan() {
        viewModel.getWorkoutPlansFromApi()
        viewModel.openWorkoutPlan(workoutPlanIndex: 1)
        XCTAssertTrue(mockdelegat.navigateToPageCalled)
    }
    
    func testGetWorkoutPlansFromApi() {
        viewModel.getWorkoutPlansFromApi()
        XCTAssertNotNil(viewModel.getworkoutPlansData())
        XCTAssertTrue(mockdelegat.reloadCalled)
    }
    
    func testGetWorkoutPlansFromApiFailed() {
        failedToRetrieveWorkoutPlans()
        XCTAssertNil(viewModel.getworkoutPlansData())
        XCTAssertTrue(mockdelegat.showErrorCalled)
    }
    
    class MockWorkoutMangerDelegate: WorkoutManagerDelegate {
        
        var reloadCalled = false
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
    
     class MockWorkoutManagerRepository:WorkoutManagerRepositoryType {
        let mockWorkoutManager = WorkoutManager(workoutPlans:
                                                    [WorkoutPlan(id: 1, name: "", description: ""),
                                                     WorkoutPlan(id: 2, name: "", description: ""),
                                                     WorkoutPlan(id: 3, name: "", description: "")])
        
         func fetchWorkoutPlans(completion: @escaping (WorkoutPlansResult)) {
            let workoutManager: WorkoutManager = mockWorkoutManager
            completion(.success(workoutManager))
        }
    }

     class MockWorkoutManagerRepositoryFail:WorkoutManagerRepositoryType {
         func fetchWorkoutPlans(completion: @escaping (WorkoutPlansResult)) {
            completion(.failure(.invalidData))
        }
    }
}
