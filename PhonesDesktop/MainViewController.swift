//
//  MainViewController.swift
//  PhonesDesktop
//
//  Created by Marcin Jackowski on 24/01/16.
//  Copyright © 2016 Marcin Jackowski. All rights reserved.
//

import Cocoa

class MainViewController: ViewController {
 
    var phonesList: [Phone] = []
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var firstBeaconView: BeaconView!
    @IBOutlet weak var secondBeaconView: BeaconView!
    @IBOutlet weak var thirdBeaconView: BeaconView!
    @IBOutlet weak var pushAlertTextField: NSTextField!
    
    var beaconsViews: [BeaconView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconsViews = [firstBeaconView, secondBeaconView, thirdBeaconView]
        refresh()
    }
    
    @IBAction func refreshButtonAction(sender: NSButton) {
        refresh()
    }
    
    @IBAction func pingPhonesActionButton(sender: NSButton) {
        if self.tableView.selectedRow != -1 {
            
            let parameters = PingService.Parameters(alert: pushAlertTextField.stringValue)
            
            PingService.ping(phonesList[self.tableView.selectedRow].databaseId, parameters: parameters) { (resutl) -> Void in
                switch resutl {
                case .Success(let phones):
                    self.refresh()
                case .Error:
                    ()
                }
            }
        }
    }
    
    @IBAction func silentPingButtonAction(sender: NSButton) {
        SilentPingService.ping(phonesList[self.tableView.selectedRow].databaseId) { (resutl) -> Void in
            switch resutl {
            case .Success(let phones):
                self.refresh()
            case .Error:
                ()
            }
        }
    }
    
    func refresh() {
        PhonesListService.getPhonesList { (resutl) -> Void in
            switch resutl {
            case .Success(let phones):
                self.phonesList = phones
                self.tableView.reloadData()
            case .Error:
                ()
            }
        }
        
        BeaconsService.getBeacons { (result) in
            switch result {
            case .Success(let beacons):
                if beacons.count == 3 {
                    for index in 0..<beacons.count {
                        let beaconView = self.beaconsViews[index]
                        beaconView.defaultSetup()
                        beaconView.majorValue = beacons[index].majorValue
                        beaconView.minorValue = beacons[index].minorValue
                        beaconView.backgroundColor = NSColor.colorForTestEstimote(beacons[index].majorValue)
                    }
                }
            case .Error:
                ()
            }
        }
    }
}

// MARK: - NSTableViewDataSource
extension MainViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return phonesList.count
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}

// MARK: - InternalLinksViewController
extension MainViewController: NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier("PhonesListTableCellView", owner: self) as? PhonesListTableCellView
        cellView?.phoneNameLabel.stringValue = phonesList[row].name
        return cellView
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        guard let row = notification.object?.selectedRow where row < phonesList.count else {
            return
        }
        
        let phone = phonesList[row]

        beaconsViews.forEach { (beacon) -> () in
            beacon.defaultSetup()
            
            if beacon.majorValue == phone.currentBeacon.majorValue {
                beacon.layer?.borderWidth = 10
                beacon.layer?.borderColor = NSColor.blackColor().CGColor
            }
            
            if beacon.majorValue == phone.lastBeacon.majorValue {
                beacon.layer?.borderWidth = 10
                beacon.layer?.borderColor = NSColor.redColor().CGColor
            }
        }
    }
}