//
//  HomeViewModel.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject, HomeVMInterfaces {
    
    private var subscriptions = Set<AnyCancellable>()
    private var apiRequest: APIServiceProtocol
    var usersResult = CurrentValueSubject<[Users]?, Never>([])
    var postsResult = CurrentValueSubject<[Posts]?, Never>([])
    internal var errorValue: String?
    
    init(apiService: APIServiceProtocol) {
        self.apiRequest = apiService
        self.isLoading = self.isLoadingProperty.eraseToAnyPublisher()
        self.feed = self.feedProperty.eraseToAnyPublisher()
        self.error = self.errorProperty.eraseToAnyPublisher()
        fetchUserToken()
        
        self.readyToBuildHomeModel.sink { isFinished in
            if isFinished {
                self.getInfoForHome()
            }
        }.store(in: &subscriptions)
    }
    
    public var inputs: HomeVMInput { return self }
    public var outputs: HomeVMOutput { return self }
    
    // MARK: Input Methods and Variables
    private var isLoadingProperty = CurrentValueSubject<Bool, Never>(false)
    private var errorProperty = PassthroughSubject<String, Never>()
    private var feedProperty = CurrentValueSubject<[HomeModel], Never>([])
    
    func loadUsers() {
        self.apiRequest.fetchUsers { users, error in
            guard error == nil else {
                self.errorProperty.send(error!.localizedDescription)
                self.isLoadingProperty.send(false)
                return
            }
            self.usersResult.send(users)
        }
    }
    
    func loadPosts() {
        self.isLoadingProperty.send(false)
        self.apiRequest.fetchPosts { posts, error in
            guard error == nil else {
                self.errorProperty.send(error!.localizedDescription)
                self.isLoadingProperty.send(false)
                return
            }
            self.postsResult.send(posts)
        }
    }
    
    func fetchUserToken() {
        self.isLoadingProperty.send(true)
        self.apiRequest.fetchUserToken(userName: "", password: "") { error in
            if error == nil {
                self.loadUsers()
                self.loadPosts()
            } else {
                self.errorValue = error?.localizedDescription
                self.errorProperty.send(error!.localizedDescription)
                self.isLoadingProperty.send(false)
            }
        }
    }
    
    func getInfoForHome(){
        if let users = self.usersResult.value, let posts = self.postsResult.value{
            var homeModel: [HomeModel] = []
            let sortedUsers = users.sorted(by: { $0.id > $1.id })
            let sortedPosts = posts.sorted(by: { $0.userId > $1.userId })
            var count = 0
            
            _ = sortedUsers.map { user in
                _ = sortedPosts.map { post in
                    if post.userId == user.id {
                        count += 1
                        homeModel.append(HomeModel(userId: user.id, postId: post.id, avatar: user.avatar, name: user.name, username: user.username, title: post.title, body: post.body))
                    }
                }
            }
            self.feedProperty.send(homeModel)
            self.isLoadingProperty.send(false)
        } else {
            self.errorProperty.send(APIError.corruptData.localizedDescription)
            self.isLoadingProperty.send(false)
        }
    }
    
    var readyToBuildHomeModel: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(postsResult, usersResult)
            .map { posts, users in
                guard let posts = posts else { return false }
                guard let users = users else { return false }

                return !posts.isEmpty && !users.isEmpty
            }.eraseToAnyPublisher()
    }
    
    func tryAPICallServices() {
        self.fetchUserToken()
    }
    
    
    // MARK: Output Methods and Variables
    public var error: AnyPublisher<String, Never>!
    public var isLoading: AnyPublisher<Bool, Never>!
    public var feed: AnyPublisher<[HomeModel], Never>!
}


