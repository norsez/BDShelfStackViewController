//
//  BDShelfStackViewController.swift
//  Pods
//
//  Created by Norsez Orankijanan on 25/10/2561 BE.
//

import UIKit
//MARK - shelf stack styling
protocol BDSSVShelfStylingDelegate {
    func stylingOnLoad(_ shelf: BDShelfStackViewController)
    func stylingCell(_ cell: UITableViewCell, index: Int)
}

public class BDShelfStackViewController: UITableViewController {
    let CELL_ID = "CELL_ID"
    
    var styling: BDSSVShelfStylingDelegate?
    var viewControllers = [UIViewController]()
    var data: BDSSVData?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.CELL_ID)
        self.styling?.stylingOnLoad(self)
        
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.rows.count ?? 0
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_ID, for: indexPath)
        
        if let row = self.data?.rows[indexPath.row] {
            if let ctrl = cell.setup(row: row) {
                self.viewControllers.append(ctrl)
            }
        }
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.styling?.stylingCell(cell, index: indexPath.row)
        let ctrl = self.viewControllers[indexPath.row]
        if let ctrl = ctrl as? UITableViewController {
            ctrl.tableView.reloadData()
        }else if let ctrl = ctrl as? UICollectionViewController {
            ctrl.collectionView?.reloadData()
        }
        
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = self.data?.rows[indexPath.row],
            let c = row.didTapItem {
            c(indexPath.row)
        }
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let h = self.data?.rows[indexPath.row].rowHeight {
            return h
        }
        return 54
    }
    
    //MARK - update table
    //update the entire
    public func createShelfStack(with data: BDSSVData) {
        self.data = data
        self.tableView.reloadData()
    }
    
    //replace a BDSSVRow in BDSSVData. This updates the whole shelf stack
    public func replaceRow(at index: Int, with row: BDSSVRow) {
        if let existingRows = self.data?.rows {
            var rows = existingRows
            rows.replaceSubrange(index...index, with: [row])
            self.data = BDSSVData(withRows: rows)
            self.reloadRow(at: index)
        }
    }
    
    //reload a row.
    public func reloadRow(at index:Int) {
        if let v = self.viewControllers[index] as? ReloadableRow,
            let row = self.data?.rows[index] {
            v.reload(with: row)
        }
    }
}


