//
//  BDSSVCell.swift
//  Pods
//
//  Created by Norsez Orankijanan on 25/10/2561 BE.
//

import UIKit

protocol ReloadableRow {
    func reload(with row: BDSSVRow)
}

//MARK: Cell for vertical stack
class VerticalStackCell: UITableViewCell {
    var _customView: UIView?
    static let TAG_CUSTOM = 9921
    var customView: UIView? {
        get {
            return _customView
        }
        
        set (v){
            _customView = v
            if let c = v {
                c.tag = VerticalStackCell.TAG_CUSTOM
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

//MARK: table for vertical stack
class VerticalStackViewController: UITableViewController, ReloadableRow {
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
        self.tableView.register(VerticalStackCell.self, forCellReuseIdentifier: self.CELLID)
        self.tableView.separatorStyle = .none
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
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as! VerticalStackCell
        cell.selectionStyle = .none
        if let c = self.row?.viewAtIndex {
            let v = c(indexPath.row)
            cell.customView = v
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let size = self._row?.itemSize {
            return size.height
        }else if let size = self._row?.sizeAtIndex {
            return size(indexPath.row).height
        }else {
            return 59
        }
    }
    
    
    func reload(with row: BDSSVRow) {
        self.row = row
        self.tableView.reloadData()
    }
}


//MARK: extension for cell
class BDSSVRowCell: UITableViewCell {
    
    let TAG_HEADER = 981
    let TAG_CTRL = 992
    var row: BDSSVRow?
    var isSetup = false
    func setup(row: BDSSVRow) -> UIViewController? {
        self.row = row
        self.selectionStyle = .none
        if let headerView = row.headerView, row.headerHeight > 0 {
            headerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            headerView.tag = self.TAG_HEADER
            self.contentView.addSubview(headerView)
        }
        
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
        ctrl.view.tag = self.TAG_CTRL
        ctrl.view.autoresizingMask = []
        
        self.contentView.addSubview(ctrl.view)
        self.isSetup = true
        return ctrl
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var layoutFrame = CGRect.zero
        
        if let headerView = self.contentView.viewWithTag(self.TAG_HEADER),
            let height = self.row?.headerHeight {
            layoutFrame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: height)
            headerView.frame = layoutFrame
        }
        
        if let ctrl = self.contentView.viewWithTag(self.TAG_CTRL),
            let height = self.row?.rowHeight {
            ctrl.frame = CGRect(x: 0, y: layoutFrame.height, width: self.contentView.bounds.width, height: height)
        }
    }
}
