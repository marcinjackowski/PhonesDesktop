//
//  Router.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Alamofire


enum Result<T> {
    case Success(T)
    case Error
}

enum Router: URLRequestConvertible {
    static let baseURLString = "http://marcin.local:3000/"
    
    var method: Alamofire.Method {
        switch self {
        case .Ping, .SilentPing:
            return .PUT
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .GetPhonesList:
            return "phones"
        case .GetBeacons:
            return "beacons"
        case .Ping(let databaseId, _):
            return "ping/" + databaseId
        case .SilentPing(let databaseId):
            return "silentping/" + databaseId
        }
    }
    
    case GetPhonesList()
    case GetBeacons()
    case Ping(String, [String: AnyObject]?)
    case SilentPing(String)

    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.URLString
        switch self {
        case .GetPhonesList:
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        case .GetBeacons:
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        case .Ping(_, let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .SilentPing(_):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        }
    }
}