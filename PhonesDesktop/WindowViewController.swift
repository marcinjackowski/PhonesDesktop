//
//  WindowViewController.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Foundation
import Cocoa

enum SegmentedControlState {
    case Push, Pop
    
    var values: (Int, Int) {
        switch self {
        case .Push:
            return (0,1)
        case .Pop:
            return (1,0)
        }
    }
}

class WindowViewController: NSWindowController {
    
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    
    var viewController: ViewController {
        get {
            return self.window!.contentViewController! as! ViewController
        }
    }
    
    var currentViewController: ViewController?
    
    @IBAction func controlNavigationAction(sender: NSSegmentedControl) {
        guard let currentViewController = currentViewController else { return }
        
        if sender.selectedSegment == 0 {
            sender.setEnabled(true, forSegment: 1)
            sender.setEnabled(false, forSegment: 0)
            
            viewController.popViewController(viewController, currentViewController: currentViewController)
        } else {
            viewController.pushViewController(currentViewController)
        }
    }
    
    func switchSegmentedControlFor(state: SegmentedControlState, viewController: ViewController?) {
        if let currentViewController = viewController {
            self.currentViewController = currentViewController
        }
        
        segmentedControl.setEnabled(true, forSegment: state.values.0)
        segmentedControl.setEnabled(false, forSegment: state.values.1)
    }
}