//
//  Phone.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 29/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation

class Phone {
    
    let databaseId: String
    let name: String
    let phoneId: String
    let currentBeacon: Beacon
    let lastBeacon: Beacon
    
    init(databaseId: String, name: String, phoneId: String, currentBeacon: Beacon, lastBeacon: Beacon) {
        self.databaseId = databaseId
        self.name = name
        self.phoneId = phoneId
        self.currentBeacon = currentBeacon
        self.lastBeacon = lastBeacon
    }
}