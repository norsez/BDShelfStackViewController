//
//  VerticalViewController.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 16/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit
import BDShelfStackViewController
//MARK - VerticalViewController
//this example only has one table and it looks like a basic UITableView
class VerticalViewController: UIViewController {
    var shelfStack: BDShelfStackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let HEIGHT_SHELF: CGFloat = 280
        let WIDTH_SHELF: CGFloat = 280
        let NUM_VISIBLE_ITEMS: CGFloat = 4.5
        let HEIGHT_ITEM = HEIGHT_SHELF/NUM_VISIBLE_ITEMS
        
        //defines the first and only table in this demo
        var rowsOfDemoTable = BDSSVRow(withType: .vertical, itemCount: 50, rowHeight: HEIGHT_SHELF)
        
        //required: sizeAtIndex
        //this defines the size of the cell
        rowsOfDemoTable.sizeAtIndex = { index in
            return CGSize(width: WIDTH_SHELF, height: HEIGHT_ITEM)
        }
        
        //required: viewAtIndex
        //this defines the view items to be displayed
        rowsOfDemoTable.viewAtIndex = { index in
            let item = DemoEngine.shared.nextItem
            let view = CellA(frame: CGRect(x: 0, y: 0, width: WIDTH_SHELF, height: HEIGHT_ITEM))
            view.imageView.image = item?.thumbnail
            view.titleLabel.text = item?.name
            view.subtitleLabel.text = item?.artist
            return view
        }
        
        //optional: didTapItem
        rowsOfDemoTable.didTapItem = {
            index in
            print("tap on item: \(index)")
        }
        
        let rows = [rowsOfDemoTable]
        let data = BDSSVData(withRows: rows)
        
        //programmatically create the shelf stack view controller
        self.shelfStack = BDShelfStackViewController(withData: data)
        
        if let ctrl = self.shelfStack {
            //adds the shelf stack to the main view controller
            self.addChildViewController(ctrl)
            let f = CGRect(x: 0, y: 0, width: WIDTH_SHELF, height: HEIGHT_SHELF)
            ctrl.view.frame = f
            ctrl.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.view.addSubview(ctrl.view)
            ctrl.view.center = self.view.center
        }
        
    }
}
