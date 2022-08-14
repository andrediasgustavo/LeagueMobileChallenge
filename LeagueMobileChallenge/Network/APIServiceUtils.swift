//
//  APIServiceUtils.swift
//  LeagueMobileChallenge
//
//  Created by André Dias  on 13/08/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation


public enum APIError: Error {
    case noInternet
    case HTTPError(statusCode: Int)
    case serverError(message: String)
    case corruptData
    case decodingError(String)
    case dataTaskError(String)
    case invalidResponseStatus
    case invalidURL

    var description: String {
        switch self {
        case .invalidURL:
            return Constants.invalidURL
        case .noInternet:
            return Constants.noInternet
        case .HTTPError(let statusCode):
            return "\(Constants.HTTPError) \(statusCode)."
        case .serverError(let message):
            return "\(Constants.serverError) \"\(message)\"."
        case .decodingError(let string):
            return string
        case .corruptData:
            return Constants.corruptData
        case .dataTaskError(let string):
            return string
        case .invalidResponseStatus:
            return Constants.invalidResponseStatus
            
        }
    }
    

}

