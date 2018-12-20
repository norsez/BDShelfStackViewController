import UIKit
import BDShelfStackViewController
import QuartzCore
extension UIColor {
    public static var randomColor: UIColor {
        get {
            return UIColor(hue: CGFloat.random(in: 0..<1.0), saturation: CGFloat.random(in: 0.5..<1.0), brightness: 0.75, alpha: 1)
        }
    }
}


extension String {
    public func _headerText() -> NSAttributedString {
        let attr: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor.lightText, .font: UIFont.boldSystemFont(ofSize: 24)]
        let str = NSAttributedString(string: self, attributes: attr)
        return str
    }
    
    static public var loremIpsum: String {
        get {
            return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        }
    }
}

extension NSAttributedString {
    static public var someText: NSAttributedString {
        let t = String.loremIpsum
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: CGFloat.random(in: 8..<24)), .foregroundColor: UIColor.randomColor.withAlphaComponent(0.9)]
        return NSAttributedString(string: t, attributes: attr)
    }
}


extension UIView {
    static func someView(withSize size: CGSize) -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let l = UILabel(frame: v.bounds)
        l.attributedText = NSAttributedString.someText
        l.numberOfLines = 0
        v.addSubview(l)
        v.backgroundColor = UIColor.randomColor
        v.layer.cornerRadius = 8
        return v
    }
    
    static func someViews(withCount count: Int, size: CGSize) -> [UIView] {
        var resutls = [UIView]()
        for _ in 0..<count {
            resutls.append(UIView.someView(withSize: size))
        }
        return resutls
    }
}

extension BDSSVRow {
    
    public static func demoRow(withCount count: Int, rowHeight: CGFloat, itemSize: CGSize, type: BDSSVShelfType ) -> BDSSVRow {
        let ROW_HEIGHT: CGFloat = rowHeight
        let items = UIView.someViews(withCount: count, size: itemSize)
        var r = BDSSVRow(withType: type , itemCount: items.count, rowHeight: ROW_HEIGHT)
        r.sizeAtIndex = {
            index in
            
            let item = items[index]
            return CGSize(width: item.bounds.width, height: item.bounds.height )
        }
        
        r.viewAtIndex = {
            index in
            let item = items[index]
            return item
        }
        return r
    }
}


extension BDSSVRow: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            var f = CGRect.zero
            if let sz = self.itemSize {
                f.size = sz
            }
            let v = UIView(frame: f)
            if let c = self.viewAtIndex {
                v.addSubview(c(0))
            }
            return v
        }
    }
}

extension BDShelfStackViewController: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        get {
            return self.view
        }
    }
}
