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
