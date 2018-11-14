//
//  CellB.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 14/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

class CellB: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._init()
    }
    
    func _init() {
        Bundle.main.loadNibNamed("CellB", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
