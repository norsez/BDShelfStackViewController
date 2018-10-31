//
//  BDSSVCell.swift
//  Pods
//
//  Created by Norsez Orankijanan on 25/10/2561 BE.
//

import UIKit
//Vertical
fileprivate class VerticalStackViewController: UITableViewController {
    fileprivate var _row: BDSSVRow?
    var row: BDSSVRow? {
        get {
            return _row
        }
        
        set (v){
            _row = v
            _row?.validate()
        }
    }
    let CELLID = "CELLID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.CELLID)
        
        if let r = self.row {
            r.validate()
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.row?.itemCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath)
        
        if let c = self.row?.viewAtIndex {
            let v = c(indexPath.row)
            cell.contentView.addSubview(v)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c = self.row?.willDisplayCell {
            c(cell, indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let c = self.row?.didTapItem {
            c(indexPath.row)
        }
    }
}

//MARK: Horizontal
fileprivate class HorizontalStackController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
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
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.CELLID)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.CELLID, for: indexPath)
        
        if let c = self.row?.viewAtIndex {
            let v = c(indexPath.row)
            cell.contentView.addSubview(v)
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
        }
        assert(false, "either self.row.sizeAtIndex or self.row.itemSize can't be nil")
    }
}

//MARK: extension for cell
extension UITableViewCell {
    
    func setup(row: BDSSVRow) -> UIViewController? {
        
        var ctrl: UIViewController
        switch row.type {
        case .horizontal:
            let flow = UICollectionViewFlowLayout()
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            let h  = HorizontalStackController(collectionViewLayout: flow)
            h.row = row
            ctrl = h
            break
        case .vertical:
            let v = VerticalStackViewController(nibName: nil, bundle: nil)
            v.row = row
            ctrl = v
            break
        }
        ctrl.view.tag = 992
        ctrl.view.autoresizingMask = []
        ctrl.view.frame = self.contentView.bounds
        self.contentView.addSubview(ctrl.view)
        
        return ctrl
    }
}

