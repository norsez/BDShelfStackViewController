//
//  BDShelfStackScene.swift
//  Pods
//
//  Created by Norsez Orankijanan on 24/10/2561 BE.
//

import UIKit

public enum BDSSVShelfType {
    case horizontal
    case vertical
}

public struct BDSSVData {
    let rows: [BDSSVRow]
    public init(withRows r: [BDSSVRow]) {
        self.rows = r
    }
}

public struct BDSSVRow {
    let type: BDSSVShelfType
    public var didTapItem: ((Int)->())?
    
    let itemCount: Int
    public var viewAtIndex: ((Int)->UIView)?
    public var willDisplayCell: ((UITableViewCell, Int)->())?
    
    public var itemSize: CGSize?
    public var sizeAtIndex: ((Int)->CGSize)?
    
    let rowHeight: CGFloat
    
    func validate() {
        assert( self.itemSize != nil || self.sizeAtIndex != nil, "either itemSize or sizeAtIndex can't be nil." )
    }
    
    public init(withType t: BDSSVShelfType, itemCount: Int, rowHeight: CGFloat) {
        self.type = t
        self.itemCount = itemCount
        self.rowHeight = rowHeight
    }
}


protocol BDSSVInteracter {
    func updateStackShelf()
}

protocol BDSSVPresenter {
    
}

protocol BDSSVViewInput {
    
}

protocol BDSSVDelegate {
    
}

