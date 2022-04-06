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

    override func setUp() {
        super.setUp()
        viewModel = WorkoutManagerViewModel(delegate: MockWorkoutMangerDelegate(),
                                            repository: MockWorkoutManagerRepository())
        viewModel.getWorkoutPlansFromApi()
    }
    
    func failedToRetrieveWorkoutPlans() {
        viewModel =  WorkoutManagerViewModel(delegate: MockWorkoutMangerDelegate(),
                                             repository: MockWorkoutManagerRepositoryFail())
        
        viewModel.getWorkoutPlansFromApi()
    }
    
    func testGetworkoutPlanByIndex () {
        XCTAssertEqual(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[1], viewModel.workoutPlan(atIndex: 1))
    }
    
    func testGetworkoutPlanByIndexFail () {
        XCTAssertNotEqual(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[2], viewModel.workoutPlan(atIndex: 1))
    }
    
    func testGetworkoutPlanByIndexGetWorkoutPlansFailed () {
        failedToRetrieveWorkoutPlans()
        XCTAssertNotNil(MockWorkoutManagerRepository().mockWorkoutManager.workoutPlans[2])
    }
    
     func testGetWorkoutPlansPass() {
         XCTAssertNotNil(viewModel.getworkoutPlansData())
    }
    
    func testGetWorkoutPlansFail() {
        failedToRetrieveWorkoutPlans()
        viewModel.getWorkoutPlansFromApi()
        XCTAssertNil(viewModel.getworkoutPlansData())
   }
    
    class MockWorkoutMangerDelegate: WorkoutManagerDelegate {
        func reloadCollectionView() {
            
        }
        
        func showError(error: String) {
            
        }
        
        func navigateToPage(itemIndex: Int?) {
            
        }
    }

}
