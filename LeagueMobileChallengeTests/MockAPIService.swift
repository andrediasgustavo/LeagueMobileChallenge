//
//  MockAPIService.swift
//  LeagueMobileChallengeTests
//
//  Created by André Dias  on 15/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

@testable import LeagueMobileChallenge


final class MockAPIService: APIServiceProtocol {
    
    var arrayOfUsers: [Users] = []
    var arrayOfPosts: [Posts] = []
    var fetchShouldReturnError: Bool = false
    
    func fetchUserToken(userName: String, password: String, completion: @escaping (Error?) -> Void) {
        if fetchShouldReturnError {
            completion(NSError(domain: "", code: -1, userInfo: nil))
        } else {
            completion(nil)
        }
            
    }
    
    func fetchUsers(completion: @escaping ([Users]?, Error?) -> Void) {
        let users = self.setupUsers()
        completion(users, nil)
    }
    
    func fetchPosts(completion: @escaping ([Posts]?, Error?) -> Void) {
        let posts = self.setupPosts()
        completion(posts, nil)
    }
    
    private func setupUsers() -> [Users] {
        arrayOfUsers.append(Users(id: 1, avatar: "https://i.pravatar.cc/150?u=Sincere@april.biz", name: "Leanne Graham", username: "Bret"))
        arrayOfUsers.append(Users(id: 2, avatar: "https://i.pravatar.cc/150?u=Shanna@melissa.tv", name: "Ervin Howell", username: "Antonette"))
        arrayOfUsers.append(Users(id: 3, avatar: "https://i.pravatar.cc/150?u=Nathan@yesenia.net", name: "Clementine Bauch", username: "Samantha"))
        arrayOfUsers.append(Users(id: 4, avatar: "https://i.pravatar.cc/150?u=Julianne.OConner@kory.org", name: "Patricia Lebsack", username: "Karianne"))
        return arrayOfUsers
    }
    
    private func setupPosts() -> [Posts] {
        arrayOfPosts.append(Posts(userId: 8, id: 72, title: "sint hic doloribus consequatur eos non id", body: "quam occaecati qui deleniti consectetur\nconsequatur aut facere quas exercitationem aliquam hic voluptas\nneque id sunt ut aut accusamus\nsunt consectetur expedita inventore velit"))
        arrayOfPosts.append(Posts(userId: 6, id: 53, title: "ut quo aut ducimus alias", body: "minima harum praesentium eum rerum illo dolore\nquasi exercitationem rerum nam\nporro quis neque quo\nconsequatur minus dolor quidem veritatis sunt non explicabo similique"))
        arrayOfPosts.append(Posts(userId: 2, id: 16, title: "sint suscipit perspiciatis velit dolorum rerum ipsa laboriosam odio", body: "suscipit nam nisi quo aperiam aut\nasperiores eos fugit maiores voluptatibus quia\nvoluptatem quis ullam qui in alias quia est\nconsequatur magni mollitia accusamus ea nisi voluptate dicta"))
        arrayOfPosts.append(Posts(userId: 4, id: 33, title: "qui explicabo molestiae dolorem", body: "rerum ut et numquam laborum odit est sit\nid qui sint in\nquasi tenetur tempore aperiam et quaerat qui in\nrerum officiis sequi cumque quod"))
        return arrayOfPosts
    }

}
