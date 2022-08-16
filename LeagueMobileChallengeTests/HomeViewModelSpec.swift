//
//  HomeViewModelSpec.swift
//  LeagueMobileChallengeTests
//
//  Created by André Dias  on 15/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import XCTest
import Combine

@testable import LeagueMobileChallenge

class HomeViewModelSpec: XCTestCase {
    
    var homeViewModel: HomeViewModel!
    var mockAPIService: MockAPIService!
    private var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        self.mockAPIService = MockAPIService()
        self.homeViewModel = .init(apiService: self.mockAPIService)
    }

    override func tearDown() {
        self.homeViewModel = nil
        self.mockAPIService = nil
    }
    
    func test_fetchUserTokenCompletionIsNil() {
        var errorValue: String?
        homeViewModel.inputs.fetchUserToken()

        errorValue = homeViewModel.errorValue
        XCTAssertNil(errorValue)
    }
    
    func test_fetchUserTokenCompletionAsError() {
        var errorValue: String?
        self.mockAPIService.fetchShouldReturnError = true
        homeViewModel.inputs.fetchUserToken()

        errorValue = homeViewModel.errorValue
        XCTAssertNotNil(errorValue)
    }
    
    func test_loadUsersMockedAPICallReturnsSuccesfully() {
        homeViewModel.inputs.loadUsers()
        
        XCTAssertNotNil(homeViewModel.usersResult.value)
        if let users = homeViewModel.usersResult.value {
            XCTAssertFalse(users.isEmpty)
        }
        XCTAssertEqual(homeViewModel.usersResult.value?.count, self.mockAPIService.arrayOfUsers.count)
    }
    
    func test_loadPostsMockedAPICallReturnsSuccesfully() {
        homeViewModel.inputs.loadPosts()
        
        XCTAssertNotNil(homeViewModel.postsResult.value)
        if let posts = homeViewModel.postsResult.value {
            XCTAssertFalse(posts.isEmpty)
        }
        XCTAssertEqual(homeViewModel.postsResult.value?.count, self.mockAPIService.arrayOfPosts.count)
    }
    
    
}
