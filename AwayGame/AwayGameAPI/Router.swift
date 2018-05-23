//
//  Router.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Alamofire
import Foundation

enum Router: URLRequestConvertible {
    
    case verifyUser(parameters: Parameters)
    case searchForGames(parameters: Parameters)
    case createTrip(parameters: Parameters)

    static let baseURLString = "https://us-central1-awaygame-api.cloudfunctions.net/api"

    var method: HTTPMethod {
        switch self {
        case .verifyUser:
            return .post
        case .searchForGames:
            return .post
        case .createTrip:
            return .post
//        case .destroyUser:
//            return .delete
        }
    }

    var path: String {
        switch self {
        case .verifyUser:
            return "/user/verify"
        case .searchForGames:
            return "/ticketmaster/searchForGames"
        case .createTrip:
            return "/trip/createTrip"
        }
        
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .verifyUser(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .searchForGames(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .createTrip(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }

        return urlRequest
    }
}

