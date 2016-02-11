//
//  BeaconSerializer.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 29/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation

class BeaconSerializer {
    
    class func getBeaconsList(responseData: Array<[String: AnyObject]>?) -> [Beacon] {
        var beacons: [Beacon] = []
        
        guard let responseData = responseData else {
            return beacons
        }
        
        for beacon in responseData {
            guard let majorValue = beacon["majorValue"] as? Int,
                minorValue = beacon["minorValue"] as? Int else {
                    return []
            }
            
            let tempBeacon = Beacon(majorValue: majorValue, minorValue: minorValue)
            beacons.append(tempBeacon)
        }
        
        return beacons
    }
}