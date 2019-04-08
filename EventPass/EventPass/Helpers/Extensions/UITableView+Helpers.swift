//
//  UITableView+Helpers.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/1/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UITableView {
    
    public func registerWithClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeing a cell with identifier: \(T.reuseIdentifier) failed.")
        }
        return cell
    }
}
