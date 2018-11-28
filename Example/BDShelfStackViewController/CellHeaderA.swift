//
//  CellHeaderA.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 28/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit
import QuartzCore

class CellHeaderA: UICollectionReusableView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var timer: Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._initialize()
    }
    
    func _initialize() {
        Bundle.main.loadNibNamed("CellHeaderA", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = UIColor(red: 1.000, green: 0.910, blue: 0.220, alpha: 1)
        self.imageView.layer.cornerRadius = 8
        self.imageView.clipsToBounds = true
        self.switchImage()
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(switchImage), userInfo: nil, repeats: true)
    }
    
    @objc func switchImage() {
        if let item = DemoEngine.shared.nextItem {
            self.imageView.image = item.thumbnail
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.sizeToFit()
    }
}
