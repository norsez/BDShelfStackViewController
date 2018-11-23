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
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
                
            })
        } else {
            print("iOS 10 or better")
        }
    }
}
