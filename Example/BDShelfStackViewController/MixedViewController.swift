//
//  ViewController.swift
//  BDShelfStackViewController
//
//  Created by norsez on 10/24/2018.
//  Copyright (c) 2018 norsez. All rights reserved.
//

import UIKit
import BDShelfStackViewController
/**
 * The main ViewController for the demo app
 *
 **/
class MixedViewController: UIViewController {
    var demoCtrl: BDShelfStackViewController?
    var data: BDSSVData?
    override func viewDidLoad() {
        super.viewDidLoad()
        //typical way to use BDShelfStackViewController
        //1. create a BDSSVData made of [BDSSVRow]
        //2. create BDShelfStackViewController with that BDSSVData
        //3. add the BDShelfStackViewController as a child ViewController to your main ViewController. Boom!
        let rows: [BDSSVRow] = [
            BDSSVRow.createHeader(),
            BDSSVRow.createDemoRow1(withWidth: self.view.bounds.width),
            BDSSVRow.createDemoRow2(),
            BDSSVRow.createDemoRow3(),
            BDSSVRow.createDemoRow4(),
            BDSSVRow.createBlankRow(withHeight: 168)]
        
        self.data = BDSSVData(withRows: rows)
        self.demoCtrl = BDShelfStackViewController(nibName: nil, bundle: nil)
        self.demoCtrl?.createShelfStack(with: self.data!)
        self.demoCtrl?.view.backgroundColor = UIColor.randomColor
        if let v = self.demoCtrl?.view {
            self.view.addSubview(v)
            v.frame = self.view.bounds
        }
        self.addChildViewController(self.demoCtrl!)
    }

}

