//
//  AutoupdatedMixedViewController.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 19/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

class AutoupdatedMixedViewController: MixedViewController {
    var timer: Timer?
    var indexToUpdate: Int = 0
    let SECS_TO_UPDATE = 5
    var timeCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timer = Timer.scheduledTimer(timeInterval: Double( SECS_TO_UPDATE ), target: self, selector: #selector(updateDemoRow), userInfo: nil, repeats: true)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer () {
        self.title = "\(timeCount)s to update…"
        timeCount = timeCount.advanced(by: 1) % SECS_TO_UPDATE
    }
    
    @objc func updateDemoRow () {
        if let _ = self.data?.rows[self.indexToUpdate] {
            
            // use .reloadRow(at:) to reload a row.
            self.demoCtrl?.reloadRow(at: self.indexToUpdate, flash: true)
            indexToUpdate = indexToUpdate.advanced(by: 1) % self.data!.rows.count
            print("update index: \(self.indexToUpdate)")
        }
    }
}
