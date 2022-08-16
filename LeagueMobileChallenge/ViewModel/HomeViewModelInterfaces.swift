//
//  HomeViewModelInterfaces.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//


import Foundation
import Combine

protocol HomeVMInput {
    func tryAPICallServices()
    func loadUsers()
    func loadPosts()
    func fetchUserToken()
}

protocol HomeVMOutput {
    var error: AnyPublisher<String, Never>! { get }
    var isLoading: AnyPublisher<Bool, Never>! { get }
    var feed: AnyPublisher<[HomeModel], Never>! { get }
}

protocol HomeVMInterfaces: HomeVMInput, HomeVMOutput {
    var inputs: HomeVMInput { get }
    var outputs: HomeVMOutput { get }
}

