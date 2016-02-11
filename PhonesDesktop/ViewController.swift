//
//  ViewController.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func popViewController(viewController: ViewController, currentViewController: ViewController) {
        viewController.dismissViewController(currentViewController)
        viewController.validate()
        
        guard let window = NSApplication.sharedApplication().mainWindow?.windowController as? WindowViewController else { return }
        window.switchSegmentedControlFor(.Pop, viewController: nil)
    }
    
    func pushViewController(viewController: ViewController) {
        guard let window = NSApplication.sharedApplication().mainWindow?.windowController as? WindowViewController else { return }
        window.switchSegmentedControlFor(.Push, viewController: viewController)
        
        let animator = CustomPresentationAnimator()
        presentViewController(viewController, animator: animator)
    }
    
    func validate() {}
}