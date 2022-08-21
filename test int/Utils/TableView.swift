//
//  TableView.swift
//  test int
//
//  Created by Артём Скрипкин on 21.08.2022.
//

import UIKit

extension UITableView {
    
    // MARK: - Cells
    
    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func registerCellNib<Cell: UITableViewHeaderFooterView>(_ cell: Cell.Type) {
        register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeuCell<Cell: UITableViewCell>(_ type: Cell.Type, indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? Cell ?? Cell()
    }
    
    // MARK: - Headers and Footers
    
    func registerHeaderFooter<View: UITableViewHeaderFooterView>(_ view: View.Type) {
        register(view, forHeaderFooterViewReuseIdentifier: view.identifier)
    }
    func registerHeaderFooterNib<View: UITableViewHeaderFooterView>(_ view: View.Type) {
        register(UINib(nibName: view.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: view.identifier)
    }
    
    func dequeueHeaderFooter<View: UITableViewHeaderFooterView>(_ view: View.Type) -> View {
        dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as? View ?? View()
    }
}
