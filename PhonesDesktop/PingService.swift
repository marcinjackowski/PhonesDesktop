//
//  PingsService.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 02/02/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Alamofire

class PingService {
    
    struct Parameters {
        
        let alert: String
        
        var dictionaryRepresentation: [String: AnyObject]? {
            var dict: [String: AnyObject] = [:]
            
            dict["alert"] = alert
            
            return dict
        }
    }
    
    class func ping(databaseId: String, parameters: Parameters, completion: (Result<String>) -> Void) {
        Alamofire.request(Router.Ping(databaseId, parameters.dictionaryRepresentation)).validate().responseJSON { request, response, result in
            switch result {
            case .Success(let value):
                completion(.Success(""))
            case .Failure(let data, let error):
                completion(.Error)
            }
        }
    }
}