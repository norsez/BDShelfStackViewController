//
//  MainViewController.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 16/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

extension String {
    func _font(name: String, size: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [
            NSAttributedStringKey.font: UIFont(name: name, size: size)!,
            NSAttributedStringKey.foregroundColor: UIColor.darkText
            ])
    }
    
    var _attr: NSAttributedString {
        get {
            return NSAttributedString(string: self, attributes: [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                NSAttributedStringKey.foregroundColor: UIColor.darkText
                ])
        }
    }
    
    func _attr(with size: CGFloat, weight: UIFont.Weight) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: size, weight: weight),
            NSAttributedStringKey.foregroundColor: UIColor.darkText
            ])
    }
}

extension NSAttributedString {
    func _concat(_ text: NSAttributedString) -> NSAttributedString {
        let attr = NSMutableAttributedString(attributedString: self)
        attr.append(text)
        return attr
    }
}

//MARK - list of code examples
class MainViewController: UITableViewController {
    let CELL_ID = "CELLID"
    enum Demo: Int {
        case vertical, horizontal
        case mixed, mixedUpdate
        static let ALL: [Demo] = [.vertical, .horizontal, .mixed, .mixedUpdate]
        
        
        var title: String {
            switch self {
            case .vertical:
                return "Simple Vertical Table"
            case .horizontal:
                return "Simple Horizontal Table"
            case .mixed:
                return "Mixed Horizontal and Veritcal"
            case .mixedUpdate:
                return "Update a stack row"
            }
        }
        
        var subtitle: String {
            switch self {
            case .vertical:
                return "The most basic pattern of creating a row of scrollable table"
            case .horizontal:
                return "Using the same the pattern as above to create a horizontal version."
            case .mixed:
                return "Building mixed horizontal and vertical tables"
            case .mixedUpdate:
                return "Force reloading a stack/row"
            }
        }
        
        var sourcefile: String {
            switch self {
            case .vertical, .horizontal:
                return "SimpleDemoViewController.swift"
            case .mixed:
                return "MixedViewController.swift"
            case .mixedUpdate:
                return "AutoupdatedMixedViewController.swift"
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Demo.ALL.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.CELL_ID)
            cell?.detailTextLabel?.numberOfLines = 0
        }
        cell?.accessoryType = .disclosureIndicator
        let item = Demo.ALL[indexPath.row]
        cell?.textLabel?.attributedText = item.title._attr(with: 18, weight: .medium)
        cell?.detailTextLabel?.attributedText = "[\(item.sourcefile)]: "._font(name: "Courier New", size: 12)._concat(item.subtitle._attr(with: 12, weight: .regular))
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Demo(rawValue: indexPath.row)!
        let ctrl: UIViewController
        switch item {
        case .vertical:
            let c = SimpleDemoViewController()
            c.shelfType = .vertical
            ctrl = c
        case .horizontal:
            let c = SimpleDemoViewController()
            c.shelfType = .horizontal
            ctrl = c
        case .mixed:
           ctrl = MixedViewController()
        case .mixedUpdate:
            ctrl = AutoupdatedMixedViewController()
        }
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 1.000, green: 0.851, blue: 0.400, alpha: 1)
    }
    
}


