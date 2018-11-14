//
//  CellA.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 13/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

class CellA: UIView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initialize()
    }
    
    func _initialize() {
        Bundle.main.loadNibNamed("CellA", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
