//
//  Router.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation

import Alamofire

//enum Router: URLRequestConvertible {
//    case createUser(parameters: Parameters)
//    case readUser(username: String)
//    case updateUser(username: String, parameters: Parameters)
//    case destroyUser(username: String)
//
//    static let baseURLString = "https://example.com"
//
//    var method: HTTPMethod {
//        switch self {
//        case .createUser:
//            return .post
//        case .readUser:
//            return .get
//        case .updateUser:
//            return .put
//        case .destroyUser:
//            return .delete
//        }
//    }
//
//    var path: String {
//        switch self {
//        case .createUser:
//            return "/users"
//        case .readUser(let username):
//            return "/users/\(username)"
//        case .updateUser(let username, _):
//            return "/users/\(username)"
//        case .destroyUser(let username):
//            return "/users/\(username)"
//        }
//    }
//
//    // MARK: URLRequestConvertible
//
//    func asURLRequest() throws -> URLRequest {
//        let url = try Router.baseURLString.asURL()
//
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//        urlRequest.httpMethod = method.rawValue
//
//        switch self {
//        case .createUser(let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        case .updateUser(_, let parameters):
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        default:
//            break
//        }
//
//        return urlRequest
//    }
//}

