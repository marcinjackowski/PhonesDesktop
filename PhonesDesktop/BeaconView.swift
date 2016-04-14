//
//  BeaconView.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 29/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Cocoa

enum StatusState {
    case Current
    case Last
    case NotSet
}

class BeaconView: NSView {
    
    var majorValue: Int?
    var minorValue: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = NSColor.clearColor()
        
        hidden = true
        layer?.cornerRadius = 12
        layer?.masksToBounds = true
    }
    
    func defaultSetup() {
        hidden = false
        layer?.cornerRadius = 12
        layer?.masksToBounds = true
    }
}