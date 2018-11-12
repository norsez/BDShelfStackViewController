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
    
    static func createDemoRow1() -> BDSSVRow {
        var r = BDSSVRow(withType: .vertical , itemCount: 30, rowHeight: 250)
        r.sizeAtIndex = {
            index in return CGSize(width: 300, height: 70)
        }
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
            v.backgroundColor = UIColor.randomColor
            let l = UILabel.label(withInt: index)
            v.addSubview(l)
            l.center = v.center
            return v
        }
        return r
    }
    static func createDemoRow2() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 35, rowHeight: 158)
        r.itemSize = CGSize(width: 144, height: 144)
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 144, height: 144))
            v.backgroundColor = UIColor.randomColor
            let l = UILabel.label(withInt: index)
            v.addSubview(l)
            l.center = v.center
            return v
        }
        return r
    }
    
    static func createDemoRow3() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 50, rowHeight: 42)
        r.itemSize = CGSize(width: 72, height: 32)
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 72, height: 32))
            v.backgroundColor = UIColor.randomColor
            let l = UILabel.label(withInt: index)
            v.addSubview(l)
            l.center = v.center
            return v
        }
        return r
    }
    
    static func createDemoRow4() -> BDSSVRow {
        var r = BDSSVRow(withType: .horizontal , itemCount: 6, rowHeight: 64)
        r.itemSize = CGSize(width: 58, height: 58)
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
            v.backgroundColor = UIColor.randomColor
            let l = UILabel.label(withInt: index)
            v.addSubview(l)
            l.center = v.center
            return v
        }
        return r
    }
}

class ViewController: UIViewController {
    var demoCtrl: BDShelfStackViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let rows: [BDSSVRow] = [BDSSVRow.createDemoRow1(),
                                BDSSVRow.createDemoRow2(),
                                BDSSVRow.createDemoRow3(),
                                BDSSVRow.createDemoRow4()]
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


class ViewController2: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView?
    let CELL_ID = "CELL_ID"
    override func viewDidLoad() {
        super.viewDidLoad()
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: 50, height: 50)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flow)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.view.addSubview(self.collectionView!)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.CELL_ID)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CELL_ID, for: indexPath)
        let label = UILabel(frame: CGRect(x: 0, y:0, width: 60, height: 60))
        label.text = "\(indexPath.item)"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: CGFloat.random(in: 0.3..<0.8), green: CGFloat.random(in: 0.3..<0.8), blue: CGFloat.random(in: 0.3..<0.8), alpha: 1)
        cell.contentView.addSubview(label)
        
        return cell
    }
}
