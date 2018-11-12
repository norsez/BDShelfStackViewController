//
//  Utils.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 31/10/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

fileprivate let PALETTE: [UIColor] =
[
    UIColor(red: 68/255.0, green: 71/255.0, blue: 95/255.0, alpha: 1.0),
    UIColor(red: 95/255.0, green: 167/255.0, blue: 191/255.0, alpha: 1.0),
    UIColor(red: 17/255.0, green: 107/255.0, blue: 91/255.0, alpha: 1.0),
    UIColor(red: 160/255.0, green: 93/255.0, blue: 38/255.0, alpha: 1.0),
    UIColor(red: 174/255.0, green: 158/255.0, blue: 137/255.0, alpha: 1.0),
    UIColor(red: 65/255.0, green: 119/255.0, blue: 143/255.0, alpha: 1.0),
    UIColor(red: 105/255.0, green: 137/255.0, blue: 126/255.0, alpha: 1.0),
    UIColor(red: 116/255.0, green: 88/255.0, blue: 37/255.0, alpha: 1.0),
    UIColor(red: 176/255.0, green: 137/255.0, blue: 35/255.0, alpha: 1.0),
    UIColor(red: 109/255.0, green: 20/255.0, blue: 25/255.0, alpha: 1.0)
]

extension UIColor {
    static var randomColor: UIColor {
        return PALETTE[Int.random(in: 0..<PALETTE.count)]
    }
}

extension UILabel {
    static func label(withInt num: Int) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.text = "\(num)"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }
}
