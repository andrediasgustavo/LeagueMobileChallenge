//
//  ServiceModel.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

struct Users: Codable {
    let id : Int
    let avatar: String
    let name: String
    let username: String
}

struct Posts: Codable {
    let userId : Int
    let id: Int
    let title: String
    let body: String
}



