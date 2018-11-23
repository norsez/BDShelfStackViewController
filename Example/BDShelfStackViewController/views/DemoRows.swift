//
//  DemoRows.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 14/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import Foundation
import BDShelfStackViewController

/**
 * Convenient functions to create example rows
 *
 **/
extension BDSSVRow {
    
    static func createHeader() -> BDSSVRow {
        //A row can be either horizontal or vertical
        let HEIGHT_1: CGFloat = CGFloat.random(in: 80..<100)
        var r = BDSSVRow(withType: .horizontal, itemCount: 1, rowHeight: HEIGHT_1)
        r.sizeAtIndex = {
            index in return CGSize(width: 1138, height: HEIGHT_1)
        }
        
        r.viewAtIndex = {
            index in
            let v = CellHeader(frame: CGRect(x: 0, y: 0, width: 1138, height: HEIGHT_1))
            v.titleLabel.attributedText = DemoEngine.shared.allNames
            return v
        }
        
        return r
    }
    
    static func createDemoRow1(withWidth maxWidth: CGFloat) -> BDSSVRow {
        let ROW_HEIGHT: CGFloat = CGFloat.random(in: 280..<320)
        let SIZE_HEIGHT: CGFloat = 100
        var r = BDSSVRow(withType: .vertical , itemCount: 37, rowHeight: ROW_HEIGHT)
        r.sizeAtIndex = {
            index in return CGSize(width: maxWidth, height: SIZE_HEIGHT )
        }
        let bgColor = UIColor.randomColor
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: maxWidth, height: SIZE_HEIGHT))
            let item = DemoEngine.shared.nextItem
            v.titleLabel.text = item?.name ?? ""
            v.subtitleLabel.text = item?.artist ?? ""
            v.imageView.image = item?.thumbnail
            v.backgroundColor = bgColor
            return v
        }
        return r
    }
    
    static func createDemoRow2() -> BDSSVRow {
        let HEIGHT = CGFloat.random(in: 158..<210)
        var r = BDSSVRow(withType: .horizontal , itemCount: 35, rowHeight: HEIGHT)
        let DIM = HEIGHT * 0.74
        r.itemSize = CGSize(width: DIM, height: DIM)
        r.viewAtIndex = {
            index in
            let v = CellB(frame: CGRect(x: 0, y: 0, width: DIM * 1.4, height: DIM))
            let item = DemoEngine.shared.nextItem
            v.titleLabel.text = "\(item?.artist ?? "")\nNew Release"
            v.imageView.image = item?.thumbnail
            
            return v
        }
        return r
    }
    
    static func createDemoRow3() -> BDSSVRow {
        let HEIGHT = CGFloat.random(in: 42..<66)
        var r = BDSSVRow(withType: .horizontal , itemCount: 53, rowHeight: HEIGHT)
        let WIDTH = CGFloat.random(in: 72..<120)
        r.itemSize = CGSize(width: WIDTH, height: HEIGHT * 0.9)
        r.viewAtIndex = {
            index in
            let v = CellB(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 0.9))
            let item = DemoEngine.shared.nextItem
            v.imageView.contentMode = .scaleAspectFill
            v.imageView.image = item?.thumbnail
            v.titleLabel.text = item?.name ?? ""
            return v
        }
        return r
    }
    
    static func createDemoRow4() -> BDSSVRow {
        let HEIGHT = CGFloat.random(in: 100..<180)
        var r = BDSSVRow(withType: .horizontal , itemCount: 26, rowHeight: HEIGHT)
        let WIDTH = CGFloat.random(in: 90..<153)
        r.itemSize = CGSize(width: WIDTH, height: HEIGHT * 0.9)
        let bgColor = UIColor.randomColor
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 0.9))
            v.backgroundColor = bgColor
            let item = DemoEngine.shared.nextItem
            v.imageView.image = item?.thumbnail
            v.titleLabel.attributedText = "\(item?.name ?? "")".attrText(with: 12)
            v.subtitleLabel.text = item?.artist ?? ""
            return v
        }
        return r
    }
    
    static func createBlankRow(withHeight h: CGFloat) -> BDSSVRow {
        var r = BDSSVRow(withType: .vertical , itemCount: 1, rowHeight: h)
        r.itemSize = CGSize(width: 400, height: h)
        
        r.viewAtIndex = {
            index in
            let v = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: h))
            v.backgroundColor = UIColor.randomColor
            return v
        }
        return r
    }
}
