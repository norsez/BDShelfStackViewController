//
//  DemoEngine.swift
//  BDShelfStackViewController_Example
//
//  Created by Norsez Orankijanan on 13/11/2561 BE.
//  Copyright © 2561 CocoaPods. All rights reserved.
//

import UIKit

/**
 * Don't look here! Quick and dirty demo util code
 **/

extension String {
    func attrText(with height: CGFloat) -> NSAttributedString {
        let par = NSMutableParagraphStyle()
        par.lineSpacing = 0
        par.lineBreakMode = .byTruncatingTail
        
        return NSAttributedString(string: self,
                                  attributes: [
                                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: height),
                                    NSAttributedStringKey.foregroundColor:
                                        UIColor.randomColor,
                                    NSAttributedStringKey.paragraphStyle:
                                     par
            ])
    }
}

extension NSAttributedString {
    static func randomStyle(withString text: String) -> NSAttributedString {
        return NSAttributedString(string: text,
                                  attributes: [
                                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat.random(in: 9..<16)),
                                    NSAttributedStringKey.foregroundColor:
                                    UIColor.randomColor
            ])
    }
}


class DemoEngine {
    private init() {}
    static let shared = DemoEngine()
    
    var data: [[String:Any]]?
    var imageCache = [String:UIImage]()
    var idIndex = 0
    
    var allNames: NSAttributedString {
        get {
            let names = NSMutableAttributedString(string:"")
            self.data?.forEach({ (d) in
                if let name = d["name"] as? String {
                    names.append(NSAttributedString.randomStyle(withString: name))
                    names.append(NSAttributedString(string: " "))
                }
            })
            return names
        }
    }
    
    var nextItem: (id: String, thumbnail: UIImage, name: String, artist: String, link: URL)? {
        get {
            let index = Int.random(in: 0..<self.data!.count)
            if let d = self.data?[index],
                let itemId = d["id"] as? String,
                let image = self.imageCache[itemId],
                let name = d["name"] as? String,
                let artist = d["artistName"] as? String,
                let urlString = d["url"] as? String,
                let url = URL(string: urlString){
                
                //idIndex = idIndex.advanced(by: 1) % self.data!.count
                
                return (id:itemId,
                        thumbnail: image,
                        name: name,
                        artist: artist,
                        link: url)
            }
            return nil
        }
    }
    
    func image(byId: String) -> UIImage? {
        return self.imageCache[byId]
    }
    
    func initialize(withProgress progress: (Float)->Void ) throws {
        guard let url = URL(string:"https://rss.itunes.apple.com/api/v1/th/apple-music/hot-tracks/all/100/explicit.json") else {
            fatalError("Apple Music is down. No demo.")
        }
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        if let feed = json["feed"] as? [String:Any],
            let results = feed["results"] as? [[String:Any]] {
            print(results)
            self.data = results
            
            var index = 0
            if let data = self.data {
                //cache thumbnails
                for r in data {
                    if let itemId = r["id"] as? String,
                        let urlString = r["artworkUrl100"] as? String,
                        let url = URL(string: urlString) {
                        do {
                            let d = try Data(contentsOf: url)
                            if let image = UIImage(data: d) {
                                self.imageCache[itemId] = image
                            }
                        }catch {
                            //skip. do nothing.
                            print(error)
                        }
                    }
                    index = index.advanced(by: 1)
                    progress(Float(index)/Float(data.count))
                }
            }
            
        }
    }
    
    
}


