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
        let HEIGHT_1: CGFloat = 100
        let r = BDSSVRow(withType: .horizontal, itemCount: 1, rowHeight: HEIGHT_1)
            .setSizeAtIndex({
                index in return CGSize(width: 1138, height: HEIGHT_1)
                
            })
            .setViewAtIndex({
                index in
                let v = CellHeader(frame: CGRect(x: 0, y: 0, width: 1138, height: HEIGHT_1))
                v.titleLabel.attributedText = DemoEngine.shared.allNames
                return v
            })
        
        
        let hv = CellHeaderA(frame: CGRect.zero)
        hv.label.attributedText = "Today's New Releases"._headerText
        r.headerView = hv
        r.headerHeight = 44
        return r
    }
    
    static func createDemoRow1(withWidth maxWidth: CGFloat) -> BDSSVRow {
        let ROW_HEIGHT: CGFloat = 300
        let SIZE_HEIGHT: CGFloat = 100
        let items = DemoEngine.shared.getItems(with: 37)
        let r = BDSSVRow(withType: .vertical , itemCount: items.count, rowHeight: ROW_HEIGHT)
        r.sizeAtIndex = {
            index in return CGSize(width: maxWidth, height: SIZE_HEIGHT )
        }
        let bgColor = UIColor.randomColor
        
        r.viewAtIndex = {
            index in
            let v = CellA(frame: CGRect(x: 0, y: 0, width: maxWidth, height: SIZE_HEIGHT))
            let item = items[index]
            v.titleLabel.attributedText = item.name.attrText(with: 18)
            v.subtitleLabel.attributedText = item.artist.attrText(with: 12)
            v.imageView.image = item.thumbnail
            v.backgroundColor = bgColor
            return v
        }
        
        let hv = CellHeaderA(frame: CGRect.zero)
        hv.label.attributedText = "15% Discount"._headerText
        r.headerView = hv
        r.headerHeight = 32
        return r
    }
    
    static func createDemoRow2() -> BDSSVRow {
        let HEIGHT: CGFloat = 180
        let items = DemoEngine.shared.getItems(with: 41)
        let DIM = HEIGHT * 0.74
        
        let r = BDSSVRow(withType: .horizontal , itemCount: items.count, rowHeight: HEIGHT)
            .setSizeAtIndex({index in return CGSize(width: DIM, height: DIM)})
            .setViewAtIndex({
                index in
                let v = CellB(frame: CGRect(x: 0, y: 0, width: DIM * 1.4, height: DIM))
                let item = items[index]
                v.titleLabel.attributedText =  NSAttributedString.randomStyle(withString:  "\(item.artist)\nNew Release" )
                v.imageView.image = item.thumbnail
                return v
            })
        
        let hv = CellHeaderA(frame: CGRect.zero)
        hv.label.attributedText = "Hot Deals"._headerText
        r.headerView = hv
        r.headerHeight = 44
        return r
    }
    
    static func createDemoRow3() -> BDSSVRow {
        let HEIGHT: CGFloat = 64
        let items = DemoEngine.shared.getItems(with: 53)
        let WIDTH = CGFloat.random(in: 72..<120)
        let r = BDSSVRow(withType: .horizontal , itemCount: items.count, rowHeight: HEIGHT)
            .setSizeAtIndex({
                index in
                return CGSize(width: WIDTH, height: HEIGHT * 0.9)
            })
            .setViewAtIndex({
                index in
                let v = CellB(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 0.9))
                let item = items[index]
                v.imageView.contentMode = .scaleAspectFill
                v.imageView.image = item.thumbnail
                v.titleLabel.attributedText = item.name.attrText(with: 12)
                return v
            })
        
        let hv = CellHeaderA(frame: CGRect.zero)
        hv.label.attributedText = "Bangkok Specials 🏬💕"._headerText
        r.headerView = hv
        r.headerHeight = 44
        
        return r
    }
    
    static func createDemoRow4() -> BDSSVRow {
        let HEIGHT: CGFloat = 176
        let items = DemoEngine.shared.getItems(with: 26)
        let WIDTH = CGFloat.random(in: 90..<153)
        let bgColor = UIColor.randomColor
        
        let r = BDSSVRow(withType: .horizontal , itemCount: items.count, rowHeight: HEIGHT)
            .setSizeAtIndex({
                index in
                return CGSize(width: WIDTH, height: HEIGHT * 0.9)
            })
            .setViewAtIndex({
                index in
                let v = CellA(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 0.9))
                v.backgroundColor = bgColor
                let item = items [index]
                v.imageView.image = item.thumbnail
                v.titleLabel.attributedText = "\(item.name)".attrText(with: 12)
                v.subtitleLabel.text = item.artist
                return v
            })
        
        let hv = CellHeaderA(frame: CGRect.zero)
        hv.label.attributedText = "📱🎼"._headerText
        r.headerView = hv
        r.headerHeight = 24
        
        return r
    }
    
    static func createBlankRow(withHeight h: CGFloat) -> BDSSVRow {
        
        let r = BDSSVRow(withType: .vertical , itemCount: 1, rowHeight: h)
            .setSizeAtIndex({
                index in
                return CGSize(width: 400, height: h)
            })
            .setViewAtIndex({
                index in
                let v = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: h))
                v.backgroundColor = UIColor.randomColor
                return v
            })
        return r
    }
}

//MARK - styling extension

extension String {
    var _headerText: NSAttributedString {
        get {
            let props: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                NSAttributedStringKey.foregroundColor: UIColor.randomColor
            ]
            
            return NSAttributedString(string: self, attributes: props)
        }
    }
}
