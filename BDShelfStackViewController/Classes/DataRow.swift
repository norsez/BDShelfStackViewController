//
//  BDShelfStackScene.swift
//  Pods
//
//  Created by Norsez Orankijanan on 24/10/2561 BE.
//

import UIKit

/**
 Model exposed to framework's client.
 */

public enum BDSSVShelfType {
    case horizontal
    case vertical
}

public struct BDSSVData {
    public let rows: [BDSSVRow]
    public init(withRows r: [BDSSVRow]) {
        self.rows = r
    }
}

/**
 * BDSSVRow is the basic building block of BDShelfStackViewController.
 * Each row's properties and behavior is defined by this class.
 * The class comes with some default settings so that api user
 * can scaffold an app quickly.
 */
public class BDSSVRow {
    let type: BDSSVShelfType
    public var didTapItem: ((Int)->())?
    let itemCount: Int
    public var viewAtIndex: ((Int)->UIView)?
    public var willDisplayCell: ((UITableViewCell, Int)->())?
    
    public var sizeAtIndex: ((Int)->CGSize)?
    
    public var headerView: UIView?
    public var headerHeight: CGFloat = 0
    
    let rowHeight: CGFloat
    
    var defaultItems: [Int:UIView]?
    
    func validate() {
        assert( self.sizeAtIndex != nil, "either itemSize or sizeAtIndex can't be nil." )
    }
    
    public init(withType t: BDSSVShelfType, itemCount: Int, rowHeight: CGFloat) {
        self.type = t
        self.itemCount = itemCount
        self.rowHeight = rowHeight
        
        self.didTapItem = {
            index in
            print("\(#line) \(#file): \(#function) didTapItem")
        }
        
        let DEFAULT_ITEM_SIZE = CGSize(width: 150, height: 58)
        
        self.sizeAtIndex = {
            index in
            return DEFAULT_ITEM_SIZE
        }
        
        self.defaultItems = [:]
        self.viewAtIndex = {
            index in
            
            if let existing = self.defaultItems?[index] {
                return existing
            }
            
            print("\(#line) \(#file): \(#function) viewAtIndex")
            var f = CGRect.zero
            f.size = DEFAULT_ITEM_SIZE
            let v = UIView(frame: f)
            v.layer.cornerRadius = 8
            v.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            v.layer.borderWidth = 0.5
            v.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
            let l = UILabel(frame: CGRect.zero)
            l.textAlignment = .center
            l.textColor = UIColor.white.withAlphaComponent(0.8)
            l.text = "\(index)"
            l.font = UIFont.boldSystemFont(ofSize: 18)
            l.sizeToFit()
            l.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
            v.addSubview(l)
            l.center = v.center
            
            self.defaultItems?[index] = v
            return v
        }
        
        self.willDisplayCell = {
            (cell, index) in
            print("\(#line) \(#file): \(#function) willDisplayCell")
        }
        
    }
    
    //Method chaining setters
    public func setDidTapItem(_ b: @escaping (Int)->()) -> BDSSVRow{
        self.didTapItem = b
        return self
    }
    
    public func setViewAtIndex(_ b: @escaping (Int)->UIView)  -> BDSSVRow{
        self.defaultItems = nil
        self.viewAtIndex = b
        return self
    }
    
    public func setWillDisplayCell(_ b: @escaping (UITableViewCell, Int)->()) -> BDSSVRow {
        self.willDisplayCell = b
        return self
    }
    
    public func setSizeAtIndex(_ b: @escaping (Int)->CGSize) -> BDSSVRow {
        self.sizeAtIndex = b
        return self
    }
}
