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
    @IBOutlet weak var pushAlertTextField: NSTextField!
    @IBOutlet weak var currentLocationLabel: NSTextField!
    @IBOutlet weak var previousLocationLabel: NSTextField!
    @IBOutlet weak var currentLocationBeaconView: BeaconView!
    @IBOutlet weak var previousLocationBeaconView: BeaconView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    @IBAction func refreshButtonAction(sender: NSButton) {
        refresh()
    }
    
    @IBAction func pingPhonesActionButton(sender: NSButton) {
        if phonesList.count > 0 {
            let index = self.tableView.selectedRow == -1 ? 0 : self.tableView.selectedRow
            
            let parameters = PingService.Parameters(alert: pushAlertTextField.stringValue)
            
            PingService.ping(phonesList[index].databaseId, parameters: parameters) { (resutl) -> Void in
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
        if phonesList.count > 0 {
            let index = self.tableView.selectedRow == -1 ? 0 : self.tableView.selectedRow
            SilentPingService.ping(phonesList[index].databaseId) { (resutl) -> Void in
                switch resutl {
                case .Success(let phones):
                    self.refresh()
                case .Error:
                    ()
                }
            }
        }
    }
    
    func refresh() {
        currentLocationLabel.stringValue = ""
        previousLocationLabel.stringValue = ""
        
        currentLocationBeaconView.hidden = true
        previousLocationBeaconView.hidden = true
        
        PhonesListService.getPhonesList { (resutl) -> Void in
            switch resutl {
            case .Success(let phones):
                self.phonesList = phones
                self.tableView.reloadData()
            case .Error:
                ()
            }
        }
    }
    
    func prepareString(majorValue: Int) -> String {
        switch majorValue {
        case 41565:
            return "Ciepły"
        case 11348:
            return "Ciemny"
        case 62127:
            return "PM"
        default:
            return ""
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

        currentLocationBeaconView.defaultSetup()
        previousLocationBeaconView.defaultSetup()
        
        currentLocationBeaconView.backgroundColor = NSColor.colorForTestEstimote(phone.currentBeacon.majorValue)
        previousLocationBeaconView.backgroundColor = NSColor.colorForTestEstimote(phone.lastBeacon.majorValue)
        
        currentLocationLabel.stringValue = prepareString(phone.currentBeacon.majorValue)
        previousLocationLabel.stringValue = prepareString(phone.lastBeacon.majorValue)
    }
}