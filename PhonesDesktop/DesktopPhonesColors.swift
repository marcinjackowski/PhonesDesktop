//
//  DesktopPhonesColor.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Cocoa

extension NSColor {
    
    class func defaultBackgroundColor() -> NSColor {
        return NSColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    }
    
    class func blueberryPieColor() -> NSColor {
        return NSColor(red: 73.0/255.0, green: 73.0/255.0, blue: 149.0/255.0, alpha: 1.0)
    }
    
    class func mintCoctailColor() -> NSColor {
        return NSColor(red: 196.0/255.0, green: 239.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    }
    
    class func icyMarshmallowColor() -> NSColor {
        return NSColor(red: 158.0/255.0, green: 220.0/255.0, blue: 236.0/255.0, alpha: 1.0)
    }
    
    class func colorForTestEstimote(majorValue: Int) -> NSColor {
        switch majorValue {
        case 41565:
            return self.blueberryPieColor()
        case 11348:
            return self.mintCoctailColor()
        case 62127:
            return self.icyMarshmallowColor()
        default:
            return self.blackColor()
        }
    }
}