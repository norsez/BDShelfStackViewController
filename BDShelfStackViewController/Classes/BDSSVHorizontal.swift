//
//  BDSSVHorizontal.swift
//  BDShelfStackViewController
//
//  Created by Norsez Orankijanan on 13/11/2561 BE.
//

import UIKit

//MARK: Horizontal cell
class HorizontalStackCell: UICollectionViewCell {
    var _customView: UIView?
    static let TAG_CUSTOM = 9921
    var customView: UIView? {
        get {
            return _customView
        }
        
        set (v){
            _customView = v
            if let c = v {
                c.tag = HorizontalStackCell.TAG_CUSTOM
                self.contentView.addSubview(c)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let customView = self.customView {
            customView.center = self.contentView.center
        }
    }
    override func prepareForReuse() {
        if let v = self.customView {
            v.removeFromSuperview()
            self.customView = nil
        }
    }
}
//MARK: table for horizontal stack
class HorizontalStackController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let CELLID = "CELLID"
    fileprivate var _row: BDSSVRow?
    var row: BDSSVRow? {
        get {
            return self._row
        }
        
        set (v){
            self._row = v
            self._row?.validate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.collectionView?.register(HorizontalStackCell.self, forCellWithReuseIdentifier: self.CELLID)
        
        if let r = self.row {
            r.validate()
            self.collectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._row?.itemCount ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CELLID, for: indexPath) as! HorizontalStackCell
        
        if let c = self.row?.viewAtIndex {
            let v = c(indexPath.row)
            cell.customView = v
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let c = self.row?.didTapItem {
            c(indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let s = self.row?.sizeAtIndex {
            return s(indexPath.item)
        }else if let s = self.row?.itemSize {
            return CGSize(width: s.width, height: s.height)
        }else {
            fatalError("either self.row.sizeAtIndex or self.row.itemSize can't be nil")
        }
    }
}
