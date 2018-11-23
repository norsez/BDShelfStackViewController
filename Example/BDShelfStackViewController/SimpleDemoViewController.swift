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

let HEIGHT_SIMPLE_SHELF: CGFloat = 280
let WIDTH_SIMPLE_SHELF: CGFloat = 280

class SimpleDemoViewController: UIViewController {
    var shelfStack: BDShelfStackViewController?
    var shelfType = BDSSVShelfType.vertical
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rows = [self.createSimpleRow(with: self.shelfType)]
        let data = BDSSVData(withRows: rows)
        
        //programmatically create the shelf stack view controller
        self.shelfStack = BDShelfStackViewController(nibName: nil, bundle: nil)
        self.shelfStack?.createShelfStack(with: data)
        if let ctrl = self.shelfStack {
            //adds the shelf stack to the main view controller
            self.addChildViewController(ctrl)
            let f = CGRect(x: 0,
                           y: 0,
                           width: WIDTH_SIMPLE_SHELF,
                           height: HEIGHT_SIMPLE_SHELF)
            ctrl.view.frame = f
            ctrl.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.view.addSubview(ctrl.view)
            ctrl.view.center = self.view.center
        }
        
    }
    
    //MARK - convy method to create row config for demo simple tables
    //This is the most simplistic pattern to create a row of table.
    func createSimpleRow(with type: BDSSVShelfType) -> BDSSVRow {
        
        let NUM_VISIBLE_ITEMS: CGFloat = 4.5
        let HEIGHT_ITEM = HEIGHT_SIMPLE_SHELF/NUM_VISIBLE_ITEMS
        let WIDTH_ITEM: CGFloat
        
        switch type {
        case .vertical:
            WIDTH_ITEM = WIDTH_SIMPLE_SHELF
        case .horizontal:
            WIDTH_ITEM = WIDTH_SIMPLE_SHELF * 0.8
        }
        
        let items = DemoEngine.shared.getItems(with: 50)
        
        //defines the first and only table in this demo
        var rowsOfDemoTable = BDSSVRow(withType: type, itemCount: items.count, rowHeight: HEIGHT_SIMPLE_SHELF)
        
        //required: sizeAtIndex
        //this defines the size of the cell
        rowsOfDemoTable.sizeAtIndex = { index in
            return CGSize(width: WIDTH_ITEM, height: HEIGHT_ITEM)
        }
        
        //required: viewAtIndex
        //this defines the view items to be displayed
        rowsOfDemoTable.viewAtIndex = { index in
            let item = items[index]
            let view = CellA(frame: CGRect(x: 0, y: 0, width: WIDTH_ITEM, height: HEIGHT_ITEM))
            view.imageView.image = item.thumbnail
            view.titleLabel.text = item.name
            view.subtitleLabel.text = item.artist
            return view
        }
        
        //optional: didTapItem
        rowsOfDemoTable.didTapItem = {
            index in
            print("tap on item: \( items[index])")
        }
        
        return rowsOfDemoTable
    }
}
