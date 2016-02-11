//
//  PhonesListSerializer.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 29/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation

class PhonesListSerializer {
    
    class func getPhonesList(responseData: Array<[String: AnyObject]>?) -> [Phone] {
        var phones: [Phone] = []
        
        guard let responseData = responseData else {
            return phones
        }
        
        for phone in responseData {
            guard let databaseId = phone["_id"] as? String, name = phone["name"] as? String,
                phoneId = phone["phoneId"] as? String,
                currentBeacon = phone["currentBeacon"] as? [String: AnyObject],
                lastBeacon = phone["lastBeacon"] as? [String: AnyObject] else {
                    return []
            }
            
            let phone = Phone(databaseId: databaseId, name: name, phoneId: phoneId, currentBeacon:  {
                
                guard let majorValue = currentBeacon["majorValue"] as? Int,
                    minorValue = currentBeacon["minorValue"] as? Int else {
                        return Beacon(majorValue: 0, minorValue: 0)
                }
                return Beacon(majorValue: majorValue, minorValue: minorValue)
                
                }(), lastBeacon: {
                    
                    guard let majorValue = lastBeacon["majorValue"] as? Int,
                        minorValue = lastBeacon["minorValue"] as? Int else {
                            return Beacon(majorValue: 0, minorValue: 0)
                    }
                    return Beacon(majorValue: majorValue, minorValue: minorValue)
                    
                }())
            phones.append(phone)
        }
        
        return phones
    }
}