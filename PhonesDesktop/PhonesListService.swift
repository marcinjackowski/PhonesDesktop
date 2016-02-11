//
//  PhoneService.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Alamofire

class PhonesListService {

    class func getPhonesList(completion: (Result<[Phone]>) -> Void) {
        Alamofire.request(Router.GetPhonesList()).validate().responseJSON { request, response, result in
            switch result {
            case .Success(let value):
                let phones = PhonesListSerializer.getPhonesList(value as? Array<[String: AnyObject]>)
                completion(.Success(phones))
            case .Failure(let data, let error):
                completion(.Error)
            }
        }
    }
}