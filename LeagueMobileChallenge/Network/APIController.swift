//
//  APIController.swift
//  LeagueMobileChallenge
//
//  Created by Kelvin Lau on 2019-01-14.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchUserToken(userName: String, password: String, completion: @escaping (Error?) -> Void)
    func fetchUsers(completion: @escaping ([Users]?, Error?) -> Void)
    func fetchPosts(completion: @escaping ([Posts]?, Error?) -> Void)
}

final class APIController: APIServiceProtocol {
    static let user = "user"
    static let password = "password"
    
    static let domain = Constants.baseURL
    let loginAPI = domain + "login"
    let postAPI = domain + "posts"
    let userAPI = domain + "users"
    
    static let shared = APIController()
    
    fileprivate var userToken: String?
    
    func fetchUserToken(userName: String = "", password: String = "", completion: @escaping (Error?) -> Void) {
        if let url = URL(string: loginAPI) {
            var headers: HTTPHeaders = [:]
            
            if let authorizationHeader = Request.authorizationHeader(user: userName, password: password) {
                headers[authorizationHeader.key] = authorizationHeader.value
            }
            
            Alamofire.request(url, headers: headers).responseJSON { (response) in
                guard response.error == nil else {
                    let error = self.handleError(error: response.error, statusCode: response.response?.statusCode)
                    completion(error)
                    return
                }
                
                if let value = response.result.value as? [AnyHashable : Any] {
                    self.userToken = value["api_key"] as? String
                    completion(nil)
                }
            }
        } else {
            completion(APIError.invalidURL)
        }
    }

    func fetchPosts(completion: @escaping ([Posts]?, Error?) -> Void) {
        if let url = URL(string: postAPI) {
            request(url: url) { data, errorTuple in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([Posts].self, from: data)
                        completion(decodedData, nil)
                    } catch {
                        completion(nil, APIError.decodingError(error.localizedDescription))
                    }
                } else {
                    let error = self.handleError(error: errorTuple.0, statusCode: errorTuple.1)
                    completion(nil, error)
                }
            }
        } else {
            completion(nil, APIError.invalidURL)
        }
    }
    
    func fetchUsers(completion: @escaping ([Users]?, Error?) -> Void) {
        if let url = URL(string: userAPI) {
            request(url: url) { data, errorTuple in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode([Users].self, from: data)
                        completion(decodedData, nil)
                    } catch {
                        completion(nil, APIError.decodingError(error.localizedDescription))
                    }
                } else {
                    let error = self.handleError(error: errorTuple.0, statusCode: errorTuple.1)
                    completion(nil, error)
                }
            }
        } else {
            completion(nil, APIError.invalidURL)
        }
    }
    
    func request(url: URL, completion: @escaping (Data?, (Error?, Int?)) -> Void) {
        guard let userToken = userToken else {
            NSLog("No user token set")
            completion(nil,(nil, nil))
            return
        }
        let authHeader: HTTPHeaders = ["x-access-token" : userToken]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: authHeader).responseJSON { (response) in
            completion(response.data, (response.error, response.response?.statusCode))
        }
    }
    
    public func handleError(error: Error?, statusCode: Int?) -> Error {
        guard let errorReponse = error, let statusCodeReponse = statusCode else {
            return APIError.noInternet
        }
        print("Error \(errorReponse.localizedDescription)")
        switch statusCodeReponse {
            case 300...499:
            return APIError.HTTPError(statusCode: statusCodeReponse)
            case 500...599:
                return APIError.serverError(message: errorReponse.localizedDescription)
            default:
            return APIError.noInternet
        }
    }

}
