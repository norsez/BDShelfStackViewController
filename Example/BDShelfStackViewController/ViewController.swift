//
//  ViewController.swift
//  BDShelfStackViewController
//
//  Created by norsez on 10/24/2018.
//  Copyright (c) 2018 norsez. All rights reserved.
//

import UIKit
import BDShelfStackViewController

extension BDSSVRow {
    static func createHeader() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal, itemCount: 1, rowHeight: 80)
        r.sizeAtIndex = {
            index in return CGSize(width: 1138, height: 80)
        }
        
        r.viewAtIndex = {
            index in
            let v = CellHeader(frame: CGRect(x: 0, y: 0, width: 1138, height: 80))
            v.titleLabel.attributedText = DemoEngine.shared.allNames
            return v
        }
        return r
    }
    static func createDemoRow1(withWidth maxWidth: CGFloat) -> BDSSVRow {
        let ROW_HEIGHT: CGFloat = 240
        let SIZE_HEIGHT: CGFloat = 100
        var r = BDSSVRow(withType: .vertical , itemCount: 30, rowHeight: ROW_HEIGHT)
        r.sizeAtIndex = {
            index in return CGSize(width: maxWidth, height: SIZE_HEIGHT )
        }
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: maxWidth, height: SIZE_HEIGHT))
            let item = DemoEngine.shared.nextItem
            v.titleLabel.text = item?.name ?? ""
            v.subtitleLabel.text = item?.artist ?? ""
            v.imageView.image = item?.thumbnail
            return v
        }
        return r
    }
    static func createDemoRow2() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 35, rowHeight: 158)
        r.itemSize = CGSize(width: 144, height: 144)
        r.viewAtIndex = {
            index in
            let v = CellB(frame: CGRect(x: 0, y: 0, width: 144, height: 144))
            let item = DemoEngine.shared.nextItem
            v.titleLabel.text = "\(item?.artist ?? "")\nNew Release"
            v.imageView.image = item?.thumbnail

            return v
        }
        return r
    }
    
    static func createDemoRow3() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 50, rowHeight: 42)
        r.itemSize = CGSize(width: 72, height: 32)
        r.viewAtIndex = {
            index in
            let v = CellB(frame: CGRect(x: 0, y: 0, width: 72, height: 32))
            let item = DemoEngine.shared.nextItem
            v.imageView.contentMode = .scaleAspectFill
            v.imageView.image = item?.thumbnail
            v.titleLabel.text = item?.name ?? ""
            return v
        }
        return r
    }
    
    static func createDemoRow4() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 26, rowHeight: 100)
        r.itemSize = CGSize(width: 120, height: 100)
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: 120, height: 100))
            let item = DemoEngine.shared.nextItem
            v.imageView.image = item?.thumbnail
            v.titleLabel.attributedText = "\(item?.name ?? "")".attrText(with: 12)
            v.subtitleLabel.text = item?.artist ?? ""
            return v
        }
        return r
    }
    
    static func createBlankRow(withHeight h: CGFloat) -> BDSSVRow {
        var r = BDSSVRow(withType: .vertical , itemCount: 0, rowHeight: h)
        r.itemSize = CGSize(width: 400, height: h)
        
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: h))
            v.backgroundColor = .white
            return v
        }
        return r
    }
}

class ViewController: UIViewController {
    var demoCtrl: BDShelfStackViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let rows: [BDSSVRow] = [
            BDSSVRow.createHeader(),
            BDSSVRow.createDemoRow1(withWidth: self.view.bounds.width),
            BDSSVRow.createDemoRow2(),
            BDSSVRow.createDemoRow3(),
            BDSSVRow.createDemoRow4(),
            BDSSVRow.createBlankRow(withHeight: 168)]
        let data = BDSSVData(withRows: rows)
        self.demoCtrl = BDShelfStackViewController(withData: data)
        if let v = self.demoCtrl?.view {
            self.view.addSubview(v)
            v.frame = self.view.bounds
        }
        self.addChildViewController(self.demoCtrl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

