//
//  HomeViewControllerTests.swift
//  LeagueMobileChallengeTests
//
//  Created by André Dias  on 16/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import XCTest

@testable import LeagueMobileChallenge

class HomeViewControllerTests: XCTestCase {
    
    private var homeVC: HomeViewController!

    override func setUp() {
        super.setUp()
        
        let navigationController = UINavigationController()
        let apiService = MockAPIService()
        let viewModel = HomeViewModel(apiService: apiService)
        self.homeVC = HomeViewController(viewModel: viewModel)
        navigationController.setViewControllers([self.homeVC], animated: false)
        
        _ = self.homeVC.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_GetFirstRow() {
        let tableView = homeVC.tableView
        let indexPath0 = IndexPath(item: 0, section: 0)
        tableView.reloadData()
        
        let firstCell = tableView.cellForRow(at: indexPath0)
        let visibleRows = tableView.indexPathsForVisibleRows
        XCTAssertNotNil(visibleRows)
        XCTAssert(tableView.indexPathsForVisibleRows!.contains(indexPath0))
        XCTAssertNotNil(firstCell)
     
    }
    
    
    func test_NumbersOfHomeFeedItems() {
        XCTAssertEqual(self.homeVC.homeFeedItems.count, 2)
    }
    
    func test_NumberOFRowsAtSectionZero() {
        XCTAssertEqual(self.homeVC.tableView.numberOfRows(inSection: 0), self.homeVC.homeFeedItems.count)
    }
  
}
