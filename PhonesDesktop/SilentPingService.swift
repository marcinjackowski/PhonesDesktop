//
//  SilentPingService.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 03/02/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Alamofire

class SilentPingService {

    class func ping(databaseId: String, completion: (Result<String>) -> Void) {
        Alamofire.request(Router.SilentPing(databaseId)).validate().responseJSON { request, response, result in
            switch result {
            case .Success(let value):
                completion(.Success(""))
            case .Failure(let data, let error):
                completion(.Error)
            }
        }
    }
}