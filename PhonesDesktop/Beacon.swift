//
//  Beacon.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation

class Beacon {
    let majorValue: Int
    let minorValue: Int
    
    init(majorValue: Int, minorValue: Int) {
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
}